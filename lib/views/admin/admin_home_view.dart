import 'package:flutter/material.dart';

import '../../controllers/controller/admin_controller.dart';

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
  late final AdminController adminController;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    adminController = AdminController();
  }

  @override
  void dispose() {
    adminController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EA),

      body: IndexedStack(
        index: selectedIndex,

        children: [
          const AdminDashboard(),

          const AdminAlunosPage(),

          const AdminAtividadesPage(),

          const AdminBolsas(),

          ConfiguracoesPage(
            adminController: adminController,
          ),
        ],
      ),

      bottomNavigationBar: AdminBottomNav(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}