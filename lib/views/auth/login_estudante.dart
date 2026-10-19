import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../controllers/controller/auth_controller.dart';
import '../../models/usuario_model.dart';
import '../../services/auth_service.dart';
import '../estudante/aluno_home_view.dart';

class LoginEstudantePage extends StatefulWidget {
  const LoginEstudantePage({super.key});

  @override
  State<LoginEstudantePage> createState() => _LoginEstudantePageState();
}

class _LoginEstudantePageState extends State<LoginEstudantePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final AuthController authController = AuthController();

  bool mostrarSenha = false;
  bool carregando = false;

  Future<void> entrar() async {
    if (carregando) return;
    final email = emailController.text.trim();
    final senha = senhaController.text;

    setState(() => carregando = true);
    try {
      await authController.login(
        email: email,
        senha: senha,
        tipo: TipoUsuario.aluno,
      );
      if (!mounted) return;

      final alunoId = authController.alunoIdLogado;
      if (alunoId == null) {
        throw const AuthProfileException(
          'O cadastro de estudante ainda não foi vinculado a esta conta.',
        );
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StudentHomeView(alunoId: alunoId),
        ),
      );
    } on FirebaseAuthException catch (error) {
      _mostrarMensagem(AuthService.mensagemErro(error));
    } on FormatException catch (error) {
      _mostrarMensagem(AuthService.mensagemErro(error));
    } catch (error, stackTrace) {
      debugPrint('Falha no login do estudante: $error');
      debugPrint(stackTrace.toString());
      _mostrarMensagem(AuthService.mensagemErro(error));
    } finally {
      if (mounted) setState(() => carregando = false);
    }
  }

  Future<void> recuperarSenha() async {
    final email = emailController.text.trim();
    setState(() => carregando = true);
    try {
      await AuthService.instance.sendPasswordResetEmail(email);
      _mostrarMensagem('Enviamos um link de recuperação para seu e-mail.');
    } on FirebaseAuthException catch (error) {
      _mostrarMensagem(AuthService.mensagemErro(error));
    } on FormatException catch (error) {
      _mostrarMensagem(AuthService.mensagemErro(error));
    } finally {
      if (mounted) setState(() => carregando = false);
    }
  }

  void _mostrarMensagem(String mensagem) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E0F4),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 670),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF4656A3),
                    ),
                    label: const Text(
                      'Voltar',
                      style: TextStyle(color: Color(0xFF4656A3), fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(48, 36, 48, 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo_menino_barsanulfo.png',
                        width: 112,
                        height: 112,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Bem-vindo!',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5056AC),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Login - Aluno',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 50),
                      _campo(
                        titulo: 'Email',
                        hint: 'seu@email.com',
                        icone: Icons.email_outlined,
                        controller: emailController,
                      ),
                      const SizedBox(height: 24),
                      _campo(
                        titulo: 'Senha',
                        hint: '••••••••',
                        icone: Icons.lock_outline,
                        controller: senhaController,
                        obscureText: !mostrarSenha,
                        suffixIcon: IconButton(
                          icon: Icon(
                            mostrarSenha
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              mostrarSenha = !mostrarSenha;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 78,
                        child: ElevatedButton(
                          onPressed: carregando ? null : entrar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE17BEA),
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: carregando
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextButton(
                        onPressed: carregando ? null : recuperarSenha,
                        child: const Text('Esqueci minha senha'),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E3F3),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Acesse com seu e-mail e senha cadastrados.',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),
                            SizedBox(height: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _campo({
    required String titulo,
    required String hint,
    required IconData icone,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Color(0xFF5056AC),
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(fontSize: 21),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF999999), fontSize: 21),
            prefixIcon: Icon(icone, size: 30, color: Colors.grey),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 22,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Color(0xFFDAD9E9)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Color(0xFFDAD9E9)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Color(0xFFE17BEA), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
