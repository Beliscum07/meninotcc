import 'package:firebase_auth/firebase_auth.dart';

class AuthProfileException implements Exception {
  const AuthProfileException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    _validarEmail(email);
    if (password.isEmpty) {
      throw const FormatException('Informe sua senha.');
    }

    return _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.trim().isEmpty) {
      throw const FormatException('Informe seu nome.');
    }
    _validarEmail(email);
    if (password.length < 6) {
      throw const FormatException(
        'A senha precisa ter pelo menos 6 caracteres.',
      );
    }

    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await credential.user?.updateDisplayName(name.trim());
    return credential;
  }

  Future<void> sendPasswordResetEmail(String email) {
    _validarEmail(email);
    return _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  Future<bool> updateCurrentUser({
    required String name,
    required String email,
    String? currentPassword,
    String? newPassword,
  }) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw StateError('Não há uma sessão autenticada.');
    }

    final emailAtualizado = email.trim();
    _validarEmail(emailAtualizado);
    final emailAlterado = emailAtualizado != user.email;
    final senhaAtualizada = newPassword?.isNotEmpty == true;

    if (senhaAtualizada && newPassword!.length < 6) {
      throw const FormatException(
        'A senha precisa ter pelo menos 6 caracteres.',
      );
    }

    if (emailAlterado || senhaAtualizada) {
      if (currentPassword == null || currentPassword.isEmpty) {
        throw const FormatException(
          'Informe sua senha atual para alterar os dados de acesso.',
        );
      }
      final emailAtual = user.email;
      if (emailAtual == null) {
        throw const FormatException(
          'Não foi possível confirmar o e-mail da conta.',
        );
      }
      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: emailAtual,
          password: currentPassword,
        ),
      );
    }

    if (senhaAtualizada) {
      await user.updatePassword(newPassword!);
    }
    if (emailAlterado) {
      await user.verifyBeforeUpdateEmail(emailAtualizado);
    }
    if (name.trim() != user.displayName) {
      await user.updateDisplayName(name.trim());
    }
    await user.reload();
    return emailAlterado;
  }

  static void _validarEmail(String email) {
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.trim())) {
      throw const FormatException('Informe um e-mail válido.');
    }
  }

  static String mensagemErro(Object error) {
    if (error is AuthProfileException) {
      return error.message;
    }
    if (error is FormatException) {
      return error.message;
    }
    if (error is! FirebaseAuthException) {
      return 'Não foi possível concluir a operação. Tente novamente.';
    }

    switch (error.code) {
      case 'invalid-email':
        return 'O e-mail informado é inválido.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-mail ou senha incorretos.';
      case 'user-disabled':
        return 'Esta conta foi desativada.';
      case 'email-already-in-use':
        return 'Este e-mail já está cadastrado.';
      case 'weak-password':
        return 'A senha precisa ter pelo menos 6 caracteres.';
      case 'operation-not-allowed':
        return 'O login por e-mail e senha não está habilitado no Firebase.';
      case 'too-many-requests':
        return 'Muitas tentativas. Aguarde um pouco e tente novamente.';
      case 'network-request-failed':
        return 'Falha de conexão. Verifique sua internet e tente novamente.';
      case 'requires-recent-login':
        return 'Entre novamente para alterar os dados de acesso.';
      default:
        return 'Não foi possível concluir a operação. Tente novamente.';
    }
  }
}
