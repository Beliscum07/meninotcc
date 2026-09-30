import 'package:flutter/foundation.dart';
import '../../models/doador_model.dart';
import '../../models/usuario_model.dart';

class AuthController extends ChangeNotifier {
  // ============================================================
  // USUÁRIOS DO SISTEMA
  // ============================================================

  final List<Usuario> _usuarios = [
    Usuario(
      id: 'admin-001',
      nome: 'Administrador',
      email: 'admin@ong.com',
      senha: 'admin123',
      tipo: TipoUsuario.admin,
    ),

    Usuario(
      id: 'aluno-001',
      nome: 'João Pedro',
      email: 'aluno@ong.com',
      senha: 'aluno123',
      tipo: TipoUsuario.aluno,
    ),
  ];

  // ============================================================
  // DOADORES
  // ============================================================

  final List<Doador> _doadores = [
    Doador(
      id: 'doador-001',
      nome: 'Doador Teste',
      email: 'doador@ong.com',
      senha: 'doador123',
      telefone: '(16) 99999-0000',
    ),
  ];

  // ============================================================
  // USUÁRIO LOGADO
  // ============================================================

  Usuario? _usuarioLogado;

  Doador? _doadorLogado;

  // ============================================================
  // GETTERS
  // ============================================================

  Usuario? get usuarioLogado => _usuarioLogado;

  Doador? get doadorLogado => _doadorLogado;

  bool get estaLogado {
    return _usuarioLogado != null || _doadorLogado != null;
  }

  // ============================================================
  // LOGIN
  // ============================================================

  bool login({
    required String email,
    required String senha,
    required TipoUsuario tipo,
  }) {
    final emailNormalizado = email.trim().toLowerCase();
    final senhaNormalizada = senha.trim();

    // ------------------------------------------------------------
    // LOGIN DOADOR
    // ------------------------------------------------------------

    if (tipo == TipoUsuario.doador) {
      for (final doador in _doadores) {
        final emailCorreto =
            doador.email.toLowerCase() == emailNormalizado;

        final senhaCorreta =
            doador.senha == senhaNormalizada;

        if (emailCorreto && senhaCorreta) {
          _doadorLogado = doador;
          _usuarioLogado = null;

          notifyListeners();

          return true;
        }
      }

      return false;
    }

    // ------------------------------------------------------------
    // LOGIN ADMIN OU ALUNO
    // ------------------------------------------------------------

    for (final usuario in _usuarios) {
      final emailCorreto =
          usuario.email.toLowerCase() == emailNormalizado;

      final senhaCorreta =
          usuario.senha == senhaNormalizada;

      final tipoCorreto =
          usuario.tipo == tipo;

      if (emailCorreto && senhaCorreta && tipoCorreto) {
        _usuarioLogado = usuario;
        _doadorLogado = null;

        notifyListeners();

        return true;
      }
    }

    return false;
  }

  // ============================================================
  // CADASTRO DOADOR
  // ============================================================

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

    // Não permite dados obrigatórios vazios.
    if (nomeFinal.isEmpty ||
        emailFinal.isEmpty ||
        telefoneFinal.isEmpty ||
        senhaFinal.isEmpty) {
      return false;
    }

    // Verifica se o e-mail já existe.
    final emailExisteEmUsuarios = _usuarios.any(
      (usuario) {
        return usuario.email.toLowerCase() == emailFinal;
      },
    );

    final emailExisteEmDoadores = _doadores.any(
      (doador) {
        return doador.email.toLowerCase() == emailFinal;
      },
    );

    if (emailExisteEmUsuarios || emailExisteEmDoadores) {
      return false;
    }

    // Cria o novo doador.
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

  // ============================================================
  // DOAÇÃO
  // ============================================================

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

  // ============================================================
  // LOGOUT
  // ============================================================

  void logout() {
    _usuarioLogado = null;
    _doadorLogado = null;

    notifyListeners();
  }
}