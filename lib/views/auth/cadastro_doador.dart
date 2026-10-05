import 'package:flutter/material.dart';

import '../../controllers/controller/auth_controller.dart';
import '../../services/api_service.dart';
import 'login_doador.dart';

class DoadorCadastroPage extends StatefulWidget {
  const DoadorCadastroPage({super.key});

  @override
  State<DoadorCadastroPage> createState() => _DoadorCadastroPageState();
}

class _DoadorCadastroPageState extends State<DoadorCadastroPage> {
  final AuthController authController = AuthController();
  final GmailService gmailService = GmailService();

  // Controllers dos campos
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();

  bool mostrarSenha = false;
  bool mostrarConfirmarSenha = false;

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();

    super.dispose();
  }

  // Função responsável pelo cadastro
  void cadastrar() async {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final telefone = telefoneController.text.trim();
    final senha = senhaController.text.trim();
    final confirmarSenha = confirmarSenhaController.text.trim();

    // Verifica se algum campo está vazio
    if (nome.isEmpty ||
        email.isEmpty ||
        telefone.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos.'),
        ),
      );

      return;
    }

    // Verifica se as senhas são iguais
    if (senha != confirmarSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não são iguais.'),
        ),
      );

      return;
    }

    final cadastroValido = authController.cadastrarDoador(
      nome: nome,
      email: email,
      telefone: telefone,
      senha: senha,
    );

    if (!cadastroValido) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Este e-mail já foi cadastrado.'),
        ),
      );
      return;
    }

    await gmailService.enviarBoasVindas(
      destinatario: email,
      nome: nome,
      tipo: 'doador',
    );

    // Volta para a tela de login sem empilhar telas extras.
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastro realizado com sucesso!'),
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginDoadorPage()),
        (route) => false,
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
                        'Cadastro - Doador',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF333333),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // NOME
                      _campo(
                        titulo: 'Nome',
                        hint: 'Seu nome completo',
                        icone: Icons.person_outline,
                        controller: nomeController,
                      ),

                      const SizedBox(height: 24),

                      // EMAIL
                      _campo(
                        titulo: 'Email',
                        hint: 'seu@email.com',
                        icone: Icons.email_outlined,
                        controller: emailController,
                      ),

                      const SizedBox(height: 24),

                      // TELEFONE
                      _campo(
                        titulo: 'Telefone',
                        hint: '(00) 00000-0000',
                        icone: Icons.phone_outlined,
                        controller: telefoneController,
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

                      const SizedBox(height: 24),

                      // CONFIRMAR SENHA
                      _campo(
                        titulo: 'Confirmar senha',
                        hint: '••••••••',
                        icone: Icons.lock_outline,
                        controller: confirmarSenhaController,
                        obscureText: !mostrarConfirmarSenha,

                        suffixIcon: IconButton(
                          icon: Icon(
                            mostrarConfirmarSenha
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),

                          onPressed: () {
                            setState(() {
                              mostrarConfirmarSenha =
                                  !mostrarConfirmarSenha;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // BOTÃO CADASTRAR
                      SizedBox(
                        width: double.infinity,
                        height: 78,

                        child: ElevatedButton(
                          onPressed: cadastrar,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE17BEA),
                            foregroundColor: Colors.white,
                            elevation: 3,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),

                          child: const Text(
                            'Criar cadastro',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // IR PARA LOGIN
                      Container(
                        width: double.infinity,

                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E3F3),
                          borderRadius: BorderRadius.circular(22),
                        ),

                        child: Column(
                          children: [

                            const Text(
                              'Já possui cadastro?',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginDoadorPage(),
                                  ),
                                );
                              },

                              child: const Text(
                                'Entrar na minha conta',
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