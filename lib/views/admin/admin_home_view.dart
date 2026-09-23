import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/admin_nav_controller.dart';
import 'widgets/admin_alunos.dart';
import 'widgets/admin_atividades.dart';
import 'widgets/admin_bolsas.dart';
import 'widgets/admin_bottom_nav.dart';
import 'widgets/admin_configuracoes.dart';
import 'widgets/admin_dashboard.dart';

class AdminHomeView extends ConsumerWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(adminNavController);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EA),
      body: _buildBody(selectedIndex),
      bottomNavigationBar: const AdminBottomNav(),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
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
