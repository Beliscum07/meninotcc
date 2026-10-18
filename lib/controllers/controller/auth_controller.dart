import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../models/doador_model.dart';
import '../../models/usuario_model.dart';
import '../../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  static final AuthController _instance = AuthController._internal();

  factory AuthController() => _instance;

  AuthController._internal() {
    _atualizarSessao(_authService.currentUser);
    _authStateSubscription = _authService.authStateChanges.listen(
      _atualizarSessao,
    );
  }

  final AuthService _authService = AuthService.instance;
  late final StreamSubscription<User?> _authStateSubscription;
  TipoUsuario _tipoSessao = TipoUsuario.aluno;
  Usuario? _usuarioLogado;
  Doador? _doadorLogado;

  Usuario? get usuarioLogado => _usuarioLogado;
  Doador? get doadorLogado => _doadorLogado;
  bool get estaLogado => _usuarioLogado != null || _doadorLogado != null;

  Future<void> login({
    required String email,
    required String senha,
    required TipoUsuario tipo,
  }) async {
    _tipoSessao = tipo;
    final credential = await _authService.signIn(email: email, password: senha);
    _atualizarSessao(credential.user);
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
    final credential = await _authService.createAccount(
      name: nome,
      email: email,
      password: senha,
    );
    _tipoSessao = TipoUsuario.doador;
    _atualizarSessao(credential.user, telefone: telefone.trim());
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

    await _authService.updateCurrentUser(
      name: nomeFinal,
      email: emailFinal,
      currentPassword: senhaAtual,
      newPassword: novaSenha,
    );

    final atualizado = Doador(
      id: atual.id,
      nome: nomeFinal,
      email: _authService.currentUser?.email ?? atual.email,
      telefone: telefoneFinal,
      totalDoado: atual.totalDoado,
    );
    _doadorLogado = atualizado;
    _atualizarSessao(_authService.currentUser, telefone: telefoneFinal);
    return true;
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
    _atualizarSessao(null);
  }

  void _atualizarSessao(User? user, {String? telefone}) {
    if (user == null) {
      _usuarioLogado = null;
      _doadorLogado = null;
      notifyListeners();
      return;
    }

    final nome = user.displayName ?? user.email?.split('@').first ?? '';
    final email = user.email ?? '';
    if (_tipoSessao == TipoUsuario.doador) {
      final doadorAnterior = _doadorLogado;
      _usuarioLogado = null;
      _doadorLogado = Doador(
        id: user.uid,
        nome: nome,
        email: email,
        telefone:
            telefone ??
            (doadorAnterior?.id == user.uid ? doadorAnterior!.telefone : ''),
        totalDoado: doadorAnterior?.id == user.uid
            ? doadorAnterior!.totalDoado
            : 0,
      );
    } else {
      _doadorLogado = null;
      _usuarioLogado = Usuario(
        id: user.uid,
        nome: nome,
        email: email,
        tipo: _tipoSessao,
      );
    }
    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_authStateSubscription.cancel());
    super.dispose();
  }
}
