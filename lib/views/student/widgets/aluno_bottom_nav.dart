import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/student_nav_controller.dart';

class StudentBottomNav extends ConsumerWidget {
  const StudentBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuta o Controller para saber qual ícone destacar
    final currentIndex = ref.watch(studentNavController);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        // Envia a ação do usuário para o Controller atualizar o estado
        ref.read(studentNavController.notifier).state = index;
      },
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Agenda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity_outlined),
          activeIcon: Icon(Icons.local_activity),
          label: 'Atividades',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school_outlined),
          activeIcon: Icon(Icons.school),
          label: 'Bolsas',
        ),
      ],
    );
  }
}
