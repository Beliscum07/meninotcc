import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../models/doador_model.dart';
import '../../models/usuario_model.dart';
import '../../services/auth_service.dart';
import '../../services/sql_connect_service.dart';

class AuthController extends ChangeNotifier {
  static final AuthController _instance = AuthController._internal();

  factory AuthController() => _instance;

  AuthController._internal() {
    unawaited(_sincronizarSessao(_authService.currentUser));
    _authStateSubscription = _authService.authStateChanges.listen(
      (user) => unawaited(_sincronizarSessao(user)),
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('Falha ao observar a sessão Firebase: $error');
        debugPrint(stackTrace.toString());
        _limparSessao();
      },
    );
  }

  final AuthService _authService = AuthService.instance;
  final SqlConnectService _sqlConnectService = SqlConnectService.instance;
  late final StreamSubscription<User?> _authStateSubscription;
  Usuario? _usuarioLogado;
  Doador? _doadorLogado;
  String? _alunoIdLogado;

  Usuario? get usuarioLogado => _usuarioLogado;
  Doador? get doadorLogado => _doadorLogado;
  String? get alunoIdLogado => _alunoIdLogado;
  bool get estaLogado => _usuarioLogado != null || _doadorLogado != null;

  Future<void> login({
    required String email,
    required String senha,
    required TipoUsuario tipo,
  }) async {
    final credential = await _authService.signIn(email: email, password: senha);
    try {
      await _carregarPerfil(credential.user, tipoEsperado: tipo);
    } catch (_) {
      await _authService.signOut();
      _limparSessao();
      rethrow;
    }
  }

  Future<void> cadastrarDoador({
    required String nome,
    required String email,
    required String telefone,
    required String senha,
  }) async {
    if (nome.trim().isEmpty || telefone.trim().isEmpty) {
      throw const FormatException('Preencha todos os campos.');
    }

    final emailNormalizado = email.trim().toLowerCase();
    final sessaoAtual = _authService.currentUser;
    late User user;
    var sessaoRecuperada = false;
    if (sessaoAtual != null) {
      if (sessaoAtual.email?.toLowerCase() != emailNormalizado) {
        throw const AuthProfileException(
          'Saia da conta atual antes de cadastrar outro doador.',
        );
      }
      user = sessaoAtual;
    } else {
      try {
        final credential = await _authService.createAccount(
          name: nome,
          email: emailNormalizado,
          password: senha,
        );
        final novoUsuario = credential.user;
        if (novoUsuario == null) {
          throw const AuthProfileException(
            'O Firebase não retornou a conta recém-criada.',
          );
        }
        user = novoUsuario;
      } on FirebaseAuthException catch (error) {
        if (error.code != 'email-already-in-use') rethrow;
        final credential = await _authService.signIn(
          email: emailNormalizado,
          password: senha,
        );
        final usuarioExistente = credential.user;
        if (usuarioExistente == null) {
          throw const AuthProfileException(
            'O Firebase não retornou a conta existente.',
          );
        }
        user = usuarioExistente;
        sessaoRecuperada = true;
      }
    }

    final perfilExistente = await _sqlConnectService.buscarMeuPerfil();
    if (perfilExistente == null) {
      await _sqlConnectService.cadastrarPerfilDoador(
        nome: nome,
        telefone: telefone,
      );
    } else {
      final TipoUsuario tipo;
      try {
        tipo = _tipoDoPerfil(perfilExistente.papel);
      } on AuthProfileException {
        if (sessaoRecuperada) await _encerrarSessaoRecuperada();
        rethrow;
      }
      if (tipo != TipoUsuario.doador) {
        if (sessaoRecuperada) await _encerrarSessaoRecuperada();
        throw const AuthProfileException(
          'Esta conta já está vinculada a outro perfil da ONG.',
        );
      }
    }

    try {
      await _carregarPerfil(user, tipoEsperado: TipoUsuario.doador);
    } on AuthProfileException {
      if (sessaoRecuperada) await _encerrarSessaoRecuperada();
      rethrow;
    }
  }

  Future<void> _encerrarSessaoRecuperada() async {
    await _authService.signOut();
    _limparSessao();
  }

  Future<bool> atualizarDoadorPerfil({
    required String nome,
    required String email,
    required String telefone,
    String? senhaAtual,
    String? novaSenha,
  }) async {
    final atual = _doadorLogado;
    if (atual == null) return false;

    final nomeFinal = nome.trim();
    final emailFinal = email.trim().toLowerCase();
    final telefoneFinal = telefone.trim();
    if (nomeFinal.isEmpty || emailFinal.isEmpty || telefoneFinal.isEmpty) {
      return false;
    }
    if (novaSenha?.isNotEmpty == true && novaSenha!.length < 6) {
      return false;
    }

    final emailAlterado = await _authService.updateCurrentUser(
      name: nomeFinal,
      email: emailFinal,
      currentPassword: senhaAtual,
      newPassword: novaSenha,
    );

    await _sqlConnectService.atualizarMeuPerfil(
      nome: nomeFinal,
      telefone: telefoneFinal,
    );

    final atualizado = Doador(
      id: atual.id,
      nome: nomeFinal,
      email: _authService.currentUser?.email ?? atual.email,
      telefone: telefoneFinal,
      totalDoado: atual.totalDoado,
    );
    _doadorLogado = atualizado;
    notifyListeners();
    return emailAlterado;
  }

  void registrarDoacao(double valor) {
    if (_doadorLogado == null || valor <= 0) {
      return;
    }

    _doadorLogado!.totalDoado += valor;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.signOut();
    _limparSessao();
  }

  Future<void> _sincronizarSessao(User? user) async {
    if (user == null) {
      _limparSessao();
      return;
    }

    try {
      await _carregarPerfil(user);
    } catch (error, stackTrace) {
      debugPrint('Não foi possível carregar o perfil SQL do usuário: $error');
      debugPrint(stackTrace.toString());
      _limparSessao();
    }
  }

  Future<void> _carregarPerfil(User? user, {TipoUsuario? tipoEsperado}) async {
    if (user == null) {
      throw const AuthProfileException(
        'O Firebase não retornou uma sessão autenticada.',
      );
    }

    final perfil = await _sqlConnectService.buscarMeuPerfil();
    if (perfil == null || perfil.uid != user.uid) {
      throw const AuthProfileException(
        'Esta conta ainda não possui um perfil ativo na ONG.',
      );
    }
    if (perfil.status.toLowerCase() != 'ativo') {
      throw const AuthProfileException(
        'O perfil desta conta está inativo. Entre em contato com a ONG.',
      );
    }

    final tipo = _tipoDoPerfil(perfil.papel);
    if (tipoEsperado != null && tipo != tipoEsperado) {
      throw const AuthProfileException(
        'Esta conta não possui o perfil selecionado.',
      );
    }

    if (tipo == TipoUsuario.admin) {
      final token = await user.getIdTokenResult(true);
      if (token.claims?['admin'] != true) {
        throw const AuthProfileException(
          'Esta conta não possui autorização administrativa.',
        );
      }
    }

    String? alunoId;
    if (tipo == TipoUsuario.aluno) {
      final aluno = await _sqlConnectService.buscarMeuPerfilAluno();
      if (aluno == null) {
        throw const AuthProfileException(
          'O cadastro de estudante ainda não foi vinculado a esta conta.',
        );
      }
      alunoId = aluno.id;
    }

    await _sqlConnectService.atualizarMeuPerfil(
      nome: perfil.nome,
      telefone: perfil.telefone,
    );

    if (tipo == TipoUsuario.doador) {
      _usuarioLogado = null;
      _doadorLogado = Doador(
        id: user.uid,
        nome: perfil.nome,
        email: user.email ?? perfil.email,
        telefone: perfil.telefone ?? '',
      );
    } else {
      _doadorLogado = null;
      _usuarioLogado = Usuario(
        id: user.uid,
        nome: perfil.nome,
        email: user.email ?? perfil.email,
        tipo: tipo,
      );
    }
    _alunoIdLogado = alunoId;
    notifyListeners();
  }

  TipoUsuario _tipoDoPerfil(String papel) {
    switch (papel.trim().toLowerCase()) {
      case 'admin':
      case 'administrador':
        return TipoUsuario.admin;
      case 'aluno':
      case 'estudante':
        return TipoUsuario.aluno;
      case 'doador':
        return TipoUsuario.doador;
      default:
        throw const AuthProfileException(
          'O perfil desta conta não possui um papel válido.',
        );
    }
  }

  void _limparSessao() {
    _usuarioLogado = null;
    _doadorLogado = null;
    _alunoIdLogado = null;
    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_authStateSubscription.cancel());
    super.dispose();
  }
}
