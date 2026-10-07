import 'package:flutter/foundation.dart';

import '../../database/mock_database.dart';
import '../../database/local_storage.dart';
import '../../models/doador_model.dart';
import '../../models/usuario_model.dart';

class AuthController extends ChangeNotifier {
  static final AuthController _instance = AuthController._internal();

  factory AuthController() => _instance;

  AuthController._internal() {
    _carregarSessao();
  }

  final List<Usuario> _usuarios = MockDatabase.usuarios
      .map(
        (usuario) => Usuario(
          id: usuario['id'] as String,
          nome: usuario['nome'] as String,
          email: usuario['email'] as String,
          senha: usuario['senha'] as String,
          tipo: _tipoPorString(usuario['tipo'] as String),
        ),
      )
      .toList();

  final List<Doador> _doadores = MockDatabase.doadores
      .map(
        (doador) => Doador(
          id: doador['id'] as String,
          nome: doador['nome'] as String,
          email: doador['email'] as String,
          senha: doador['senha'] as String,
          telefone: doador['telefone'] as String,
          totalDoado: (doador['totalDoado'] as num?)?.toDouble() ?? 0.0,
        ),
      )
      .toList();

  Usuario? _usuarioLogado;
  Doador? _doadorLogado;

  Usuario? get usuarioLogado => _usuarioLogado;
  Doador? get doadorLogado => _doadorLogado;
  bool get estaLogado => _usuarioLogado != null || _doadorLogado != null;

  Future<void> _carregarSessao() async {
    final usuarioMap = await LocalStorage.carregarUsuarioLogado();
    final doadorMap = await LocalStorage.carregarDoadorLogado();

    if (usuarioMap != null) {
      _usuarioLogado = Usuario(
        id: usuarioMap['id'] as String,
        nome: usuarioMap['nome'] as String,
        email: usuarioMap['email'] as String,
        senha: usuarioMap['senha'] as String,
        tipo: _tipoPorString(usuarioMap['tipo'] as String),
      );
    }

    if (doadorMap != null) {
      _doadorLogado = Doador(
        id: doadorMap['id'] as String,
        nome: doadorMap['nome'] as String,
        email: doadorMap['email'] as String,
        senha: doadorMap['senha'] as String,
        telefone: doadorMap['telefone'] as String,
        totalDoado: (doadorMap['totalDoado'] as num?)?.toDouble() ?? 0.0,
      );
    }

    notifyListeners();
  }

  static TipoUsuario _tipoPorString(String valor) {
    switch (valor) {
      case 'admin':
        return TipoUsuario.admin;
      case 'doador':
        return TipoUsuario.doador;
      case 'aluno':
      default:
        return TipoUsuario.aluno;
    }
  }

  bool login({
    required String email,
    required String senha,
    required TipoUsuario tipo,
  }) {
    final emailNormalizado = email.trim().toLowerCase();
    final senhaNormalizada = senha.trim();

    if (tipo == TipoUsuario.doador) {
      for (final doador in _doadores) {
        final emailCorreto = doador.email.toLowerCase() == emailNormalizado;
        final senhaCorreta = doador.senha == senhaNormalizada;

        if (emailCorreto && senhaCorreta) {
          _doadorLogado = doador;
          _usuarioLogado = null;
          LocalStorage.salvarDoadorLogado({
            'id': doador.id,
            'nome': doador.nome,
            'email': doador.email,
            'senha': doador.senha,
            'telefone': doador.telefone,
            'totalDoado': doador.totalDoado,
          });
          notifyListeners();
          return true;
        }
      }
      return false;
    }

    for (final usuario in _usuarios) {
      final emailCorreto = usuario.email.toLowerCase() == emailNormalizado;
      final senhaCorreta = usuario.senha == senhaNormalizada;
      final tipoCorreto = usuario.tipo == tipo;

      if (emailCorreto && senhaCorreta && tipoCorreto) {
        _usuarioLogado = usuario;
        _doadorLogado = null;
        LocalStorage.salvarUsuarioLogado({
          'id': usuario.id,
          'nome': usuario.nome,
          'email': usuario.email,
          'senha': usuario.senha,
          'tipo': usuario.tipo.name,
        });
        notifyListeners();
        return true;
      }
    }

    return false;
  }

  bool cadastrarDoador({
    required String nome,
    required String email,
    required String telefone,
    required String senha,
  }) {
    final nomeFinal = nome.trim();
    final emailFinal = email.trim().toLowerCase();
    final telefoneFinal = telefone.trim();
    final senhaFinal = senha.trim();

    if (nomeFinal.isEmpty ||
        emailFinal.isEmpty ||
        telefoneFinal.isEmpty ||
        senhaFinal.isEmpty) {
      return false;
    }

    final emailExisteEmUsuarios = _usuarios.any(
      (usuario) => usuario.email.toLowerCase() == emailFinal,
    );

    final emailExisteEmDoadores = _doadores.any(
      (doador) => doador.email.toLowerCase() == emailFinal,
    );

    if (emailExisteEmUsuarios || emailExisteEmDoadores) {
      return false;
    }

    final novoDoador = Doador(
      id: 'doador-${_doadores.length + 1}',
      nome: nomeFinal,
      email: emailFinal,
      telefone: telefoneFinal,
      senha: senhaFinal,
    );

    _doadores.add(novoDoador);
    notifyListeners();
    return true;
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
    if (senhaAtual != null &&
        senhaAtual.isNotEmpty &&
        senhaAtual != atual.senha) {
      return false;
    }
    if (novaSenha != null && novaSenha.isNotEmpty && novaSenha.length < 6) {
      return false;
    }

    final emailEmUso =
        _usuarios.any((usuario) => usuario.email.toLowerCase() == emailFinal) ||
        _doadores.any(
          (doador) =>
              doador.id != atual.id && doador.email.toLowerCase() == emailFinal,
        );
    if (emailEmUso) return false;

    final atualizado = Doador(
      id: atual.id,
      nome: nomeFinal,
      email: emailFinal,
      telefone: telefoneFinal,
      senha: novaSenha?.isNotEmpty == true ? novaSenha! : atual.senha,
      totalDoado: atual.totalDoado,
    );
    final index = _doadores.indexWhere((doador) => doador.id == atual.id);
    if (index >= 0) _doadores[index] = atualizado;
    _doadorLogado = atualizado;

    await LocalStorage.salvarDoadorLogado({
      'id': atualizado.id,
      'nome': atualizado.nome,
      'email': atualizado.email,
      'senha': atualizado.senha,
      'telefone': atualizado.telefone,
      'totalDoado': atualizado.totalDoado,
    });
    notifyListeners();
    return true;
  }

  void registrarDoacao(double valor) {
    if (_doadorLogado == null) {
      return;
    }

    if (valor <= 0) {
      return;
    }

    _doadorLogado!.totalDoado += valor;
    notifyListeners();
  }

  Future<void> logout() async {
    _usuarioLogado = null;
    _doadorLogado = null;
    await LocalStorage.limparSessao();
    notifyListeners();
  }
}
