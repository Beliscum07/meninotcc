import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/student_nav_controller.dart';
import 'widgets/aluno_bottom_nav.dart';
import 'widgets/aluno_my_area.dart';
import 'widgets/aluno_agenda.dart';
import 'widgets/aluno_atividades.dart';
import 'widgets/aluno_notificacoes.dart';

class StudentHomeView extends ConsumerWidget {
  const StudentHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // A View "escuta" o Controller
    final selectedIndex = ref.watch(studentNavController);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Cor de fundo 
      body: _buildBody(selectedIndex),
      bottomNavigationBar: const StudentBottomNav(),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0: return const StudentMyArea();
      case 1: return const StudentAgenda();
      case 2: return const StudentActivities();
      case 3: return const StudentScholarships();
      default: return const StudentMyArea();
    }
  }
}