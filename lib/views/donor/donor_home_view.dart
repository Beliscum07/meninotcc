import 'package:flutter/material.dart';
import 'widgets/donor_bottom_nav.dart';

class DonorHomeView extends StatefulWidget {
  const DonorHomeView({super.key});

  @override
  State<DonorHomeView> createState() => _DonorHomeViewState();
}

class _DonorHomeViewState extends State<DonorHomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: _buildBody(_selectedIndex),
      bottomNavigationBar: DonorBottomNav(
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
        return const Center(child: Text('Início - Doador'));
      case 1:
        return const Center(child: Text('Minhas Doações'));
      case 2:
        return const Center(child: Text('Perfil'));
      default:
        return const Center(child: Text('Início - Doador'));
    }
  }
}
