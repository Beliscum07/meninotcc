import 'package:flutter/material.dart';
import '../student/aluno_home_view.dart';

class LoginEstudantePage extends StatefulWidget {
  const LoginEstudantePage({super.key});

  @override
  State<LoginEstudantePage> createState() => _LoginEstudantePageState();
}

class _LoginEstudantePageState extends State<LoginEstudantePage> {
  final _emailController = TextEditingController(text: 'admin@ong.com');
  final _passwordController = TextEditingController(text: 'admin123');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // TODO: implementar autenticação real
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const StudentHomeView()),
    );
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
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: Offset(0, 5)))],
                    ),
                    child: const Icon(Icons.school, color: Colors.white, size: 72),
                  ),
                  const SizedBox(height: 36),
                  Text('Login Estudante', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'E-mail', border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Senha', border: OutlineInputBorder())),
                  const SizedBox(height: 24),
                  SizedBox(width: double.infinity, height: 48, child: ElevatedButton(onPressed: _login, child: const Text('Entrar'))),
                  const SizedBox(height: 12),
                  TextButton(onPressed: () {}, child: const Text('Esqueci minha senha')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
