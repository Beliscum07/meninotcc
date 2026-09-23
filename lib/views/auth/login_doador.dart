import 'package:flutter/material.dart';
import '../donor/donor_home_view.dart';

class LoginDoadorPage extends StatefulWidget {
  const LoginDoadorPage({super.key});

  @override
  State<LoginDoadorPage> createState() => _LoginDoadorPageState();
}

class _LoginDoadorPageState extends State<LoginDoadorPage> {
  final _emailController = TextEditingController(text: 'doador@ong.com');
  final _passwordController = TextEditingController(text: 'doador123');
  String mensagem = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_emailController.text == 'doador@ong.com' &&
        _passwordController.text == 'doador123') {
      setState(() {
        mensagem = 'Login realizado com sucesso!';
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DonorHomeView()),
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB9A9D9), Color(0xFFEFE3DC)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 18),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF5153AA),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.volunteer_activism,
                      color: Colors.white,
                      size: 72,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'Login Doador',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text('Entrar'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (mensagem.isNotEmpty) ...[
                    const SizedBox(height: 15),
                    Text(
                      mensagem,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9E6F5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Credenciais de teste:',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '📧 doador@ong.com | 🔑 doador123',
                          style: TextStyle(color: Color(0xFF555555)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
