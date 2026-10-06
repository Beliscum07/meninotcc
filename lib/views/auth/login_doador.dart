import 'package:flutter/material.dart';

import '../../controllers/controller/auth_controller.dart';
import '../../models/usuario_model.dart';
import '../doador/doador_home_view.dart';
import 'cadastro_doador.dart';

class LoginDoadorPage extends StatefulWidget {
  const LoginDoadorPage({super.key});

  @override
  State<LoginDoadorPage> createState() => _LoginDoadorPageState();
}

class _LoginDoadorPageState extends State<LoginDoadorPage> {
  // Controllers dos campos
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final AuthController authController = AuthController();

  bool mostrarSenha = false;

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();

    super.dispose();
  }

  // FUNÇÃO DE LOGIN
  void entrar() {
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    final loginValido = authController.login(
      email: email,
      senha: senha,
      tipo: TipoUsuario.doador,
    );

    if (loginValido) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DonorHomeView(),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email ou senha incorretos.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E0F4),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 670,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // BOTÃO VOLTAR
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

                      style: TextStyle(
                        color: Color(0xFF4656A3),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // CARD PRINCIPAL
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    48,
                    36,
                    48,
                    40,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Column(
                    children: [

                      // ÍCONE
                      Container(
                        width: 96,
                        height: 96,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFE17BEA),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),

                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 52,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // TÍTULO
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
                        'Login - Doador',

                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF333333),
                        ),
                      ),

                      const SizedBox(height: 50),

                      // EMAIL
                      _campo(
                        titulo: 'Email',
                        hint: 'seu@email.com',
                        icone: Icons.email_outlined,
                        controller: emailController,
                      ),

                      const SizedBox(height: 24),

                      // SENHA
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

                      // BOTÃO ENTRAR
                      SizedBox(
                        width: double.infinity,
                        height: 78,

                        child: ElevatedButton(
                          onPressed: entrar,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE17BEA),
                            foregroundColor: Colors.white,
                            elevation: 3,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),

                          child: const Text(
                            'Entrar',

                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      // CREDENCIAIS DE TESTE
                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E3F3),
                          borderRadius: BorderRadius.circular(22),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            const Text(
                              'Credenciais de teste:',

                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),

                            const SizedBox(height: 14),

                            const Text(
                              '📧 doador@ong.com   |   🔑 doador123',

                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0xFF555555),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // CADASTRO
                            Center(
                              child: Column(
                                children: [

                                  const Text(
                                    'Não tem cadastro?',

                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0xFF555555),
                                    ),
                                  ),

                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DoadorCadastroPage(),
                                        ),
                                      );
                                    },

                                    child: const Text(
                                      'Cadastre-se aqui',

                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF5056AC),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

  // CAMPO DE TEXTO REUTILIZÁVEL
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

          style: const TextStyle(
            fontSize: 21,
          ),

          decoration: InputDecoration(
            hintText: hint,

            hintStyle: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 21,
            ),

            prefixIcon: Icon(
              icone,
              size: 30,
              color: Colors.grey,
            ),

            suffixIcon: suffixIcon,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 22,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),

              borderSide: const BorderSide(
                color: Color(0xFFDAD9E9),
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),

              borderSide: const BorderSide(
                color: Color(0xFFDAD9E9),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),

              borderSide: const BorderSide(
                color: Color(0xFFE17BEA),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}