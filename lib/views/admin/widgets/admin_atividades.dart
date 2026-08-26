import 'package:flutter/material.dart';

class AdminAtividades extends StatefulWidget {
  const AdminAtividades({super.key});

  @override
  State<AdminAtividades> createState() => _AdminAtividadesState();
}

class _AdminAtividadesState extends State<AdminAtividades> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Atividades'),
      ),
    );
  }
}