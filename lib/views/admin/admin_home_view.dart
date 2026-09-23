import 'package:flutter/material.dart';
import 'widgets/admin_alunos.dart';
import 'widgets/admin_atividades.dart';
import 'widgets/admin_bolsas.dart';
import 'widgets/admin_bottom_nav.dart';
import 'widgets/admin_configuracoes.dart';
import 'widgets/admin_dashboard.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EA),
      body: _buildBody(),
      bottomNavigationBar: AdminBottomNav(
        currentIndex: _selectedIndex,
        onTap: _selectPage,
      ),
    );
  }

  void _selectPage(int index) {
    if (index == _selectedIndex) return;

    // Adia a alteração de estado para o próximo frame para evitar
    // erros de "Cannot hit test a render box that has never been laid out"
    // que podem ocorrer se a árvore de widgets mudar enquanto um gesto
    // (ripple/hit test) ainda está em andamento.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _selectedIndex = index;
      });
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const AdminDashboard();
      case 1:
        return const AdminAlunosPage();
      case 2:
        return const AdminAtividadesPage();
      case 3:
        return const AdminBolsas();
      case 4:
        return const ConfiguracoesPage();
      default:
        return const AdminDashboard();
    }
  }
}
