import 'package:flutter/material.dart';

class LoginEstudantePage extends StatelessWidget {
  const LoginEstudantePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Estudante')),
      body: const Center(
        child: Text('Página de login do estudante (placeholder)'),
      ),
    );
  }
}
