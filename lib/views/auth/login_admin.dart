import 'package:flutter/material.dart';
import '../admin/admin_home_view.dart';

// Tela de login do administrador — apenas view (sem tocar em controllers)
class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  // Variáveis locais que guardam o que o usuário digita
  String email = 'admin@ong.com'; // pré-preenchido como credencial de teste
  String senha = 'admin123'; // pré-preenchido como credencial de teste

  // Mensagem de feedback exibida na tela após tentativa de login
  String mensagem = '';

  // Faz o login localmente na view: compara com credenciais de teste.
  // Se válidas, navega para `AdminHomeView`. Caso contrário, atualiza
  // `mensagem` para informar o usuário.
  void fazerLogin() {
    if (email == 'admin@ong.com' && senha == 'admin123') {
      setState(() {
        mensagem = 'Login realizado com sucesso! Redirecionando...';
      });

      // Navega para a tela do administrador e substitui a rota atual.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AdminHomeView()),
      );
    } else {
      setState(() {
        mensagem = 'E-mail ou senha incorretos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo suave para destacar o cartão branco
      backgroundColor: const Color(0xFFE5DDF2),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // BOTÃO VOLTAR alinhado à esquerda
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF4656A3)),
                    label: const Text('Voltar', style: TextStyle(color: Color(0xFF4656A3), fontSize: 16)),
                  ),
                ),

                const SizedBox(height: 15),

                // CAIXA BRANCA que contém o formulário
                Container(
                  width: 450,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 10)),
                    ],
                  ),

                  child: Column(
                    children: [

                      // ÍCONE DO CORAÇÃO
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(color: Color(0xFFE276F0), shape: BoxShape.circle),
                        child: const Icon(Icons.favorite, color: Colors.white, size: 34),
                      ),

                      const SizedBox(height: 18),

                      // TÍTULO
                      const Text('Bem-vindo!', style: TextStyle(color: Color(0xFF4656A3), fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      const Text('Login - Administrador', style: TextStyle(color: Color(0xFF444444), fontSize: 14)),
                      const SizedBox(height: 35),

                      // LABEL EMAIL
                      const Align(alignment: Alignment.centerLeft, child: Text('Email', style: TextStyle(color: Color(0xFF4656A3), fontSize: 14, fontWeight: FontWeight.w500))),
                      const SizedBox(height: 8),

                      // CAMPO EMAIL — atualiza a variável `email` local
                      TextField(
                        onChanged: (valor) => email = valor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'seu@email.com',
                          prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFD9DCEB))),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFD9DCEB))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE276F0), width: 2)),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // LABEL SENHA
                      const Align(alignment: Alignment.centerLeft, child: Text('Senha', style: TextStyle(color: Color(0xFF4656A3), fontSize: 14, fontWeight: FontWeight.w500))),
                      const SizedBox(height: 8),

                      // CAMPO SENHA — atualiza a variável `senha` local
                      TextField(
                        onChanged: (valor) => senha = valor,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFD9DCEB))),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFD9DCEB))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE276F0), width: 2)),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // BOTÃO ENTRAR
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: fazerLogin,
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE276F0), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 2),
                          child: const Text('Entrar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),

                      // MENSAGEM DE FEEDBACK (exibe erro ou sucesso)
                      if (mensagem.isNotEmpty) ...[
                        const SizedBox(height: 15),
                        Text(mensagem, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500)),
                      ],

                      const SizedBox(height: 24),

                      // CAIXA COM CREDENCIAIS DE TESTE (apenas informativa)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: const Color(0xFFE9E6F5), borderRadius: BorderRadius.circular(15)),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Credenciais de teste:', style: TextStyle(color: Color(0xFF333333), fontWeight: FontWeight.w500)),
                            SizedBox(height: 8),
                            Text('📧 admin@ong.com | 🔑 admin123', style: TextStyle(color: Color(0xFF555555))),
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
}