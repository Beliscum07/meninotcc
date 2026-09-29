import 'package:flutter/material.dart';

import 'widgets/aluno_agenda_view.dart';
import 'widgets/aluno_notificacoes_view.dart';
import 'widgets/aluno_perfil_view.dart';

class AlunoHomeView extends StatefulWidget {
  const AlunoHomeView({super.key});

  @override
  State<AlunoHomeView> createState() => _AlunoHomeViewState();
}

class _AlunoHomeViewState extends State<AlunoHomeView> {
  int selectedIndex = 0;

  final List<Widget> telas = const [
    AlunoAgendaView(),
    AlunoNotificacoesView(),
    AlunoPerfilView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: telas[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFE17BEA),
        unselectedItemColor: const Color(0xFF555555),
        selectedFontSize: 16,
        unselectedFontSize: 16,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            activeIcon: Icon(Icons.notifications),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class StudentHomeView extends AlunoHomeView {
  const StudentHomeView({super.key});
}