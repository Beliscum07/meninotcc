import 'package:flutter/material.dart';
import 'widgets/admin_bottom_nav.dart';
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
      backgroundColor: const Color(0xFFF5F5F5),
      body: _buildBody(_selectedIndex),
      bottomNavigationBar: AdminBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const AdminDashboard();
      case 1:
        return const Center(child: Text('Alunos'));
      case 2:
        return const Center(child: Text('Configurações'));
      default:
        return const AdminDashboard();
    }
  }
}
