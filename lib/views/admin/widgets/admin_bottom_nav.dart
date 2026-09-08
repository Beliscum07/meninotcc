import 'package:flutter/material.dart';

class AdminBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,

      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFFC56BE0),
      unselectedItemColor: Colors.grey,

      selectedFontSize: 11,
      unselectedFontSize: 11,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          activeIcon: Icon(Icons.people),
          label: 'Alunos',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          activeIcon: Icon(Icons.calendar_today),
          label: 'Atividades',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.workspace_premium_outlined),
          activeIcon: Icon(Icons.workspace_premium),
          label: 'Bolsas',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: 'Mais',
        ),
      ],
    );
  }
}