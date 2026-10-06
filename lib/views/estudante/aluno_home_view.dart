import 'package:flutter/material.dart';

import '../../controllers/controller/aluno_controller.dart';
import '../../models/atividade_model.dart';
import '../../services/aluno_data_service.dart';
import 'widgets/aluno_agenda_view.dart';
import 'widgets/aluno_notificacoes_view.dart';
import 'widgets/aluno_perfil_view.dart';

class AlunoHomeView extends StatefulWidget {
  final String alunoId;

  const AlunoHomeView({
    super.key,
    this.alunoId = '001',
  });

  @override
  State<AlunoHomeView> createState() => _AlunoHomeViewState();
}

class _AlunoHomeViewState extends State<AlunoHomeView> {
  late final AlunoController alunoController;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    alunoController = AlunoController();
  }

  @override
  void dispose() {
    alunoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: AlunoDataService.instance,
        builder: (context, child) => _buildTela(),
      ),

      bottomNavigationBar: ListenableBuilder(
        listenable: alunoController,

        builder: (context, child) {
          final quantidade =
              alunoController.quantidadeNotificacoesNaoLidas;

          return BottomNavigationBar(
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

            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                activeIcon: Icon(Icons.calendar_month),
                label: 'Agenda',
              ),

              BottomNavigationBarItem(
                icon: _iconeNotificacao(
                  Icons.notifications_none,
                  quantidade,
                ),

                activeIcon: _iconeNotificacao(
                  Icons.notifications,
                  quantidade,
                ),

                label: 'Notificações',
              ),

              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTela() {
    final aluno = AlunoDataService.instance.alunoPorId(widget.alunoId);

    switch (selectedIndex) {
      case 0:
        return AlunoAgendaView(
          alunoNome: aluno?['nome']?.toString() ?? 'Aluno',
          atividades: _atividadesAgendadas(aluno),
        );

      case 1:
        return AlunoNotificacoesView(
          alunoController: alunoController,
        );

      case 2:
        return AlunoPerfilView(alunoId: widget.alunoId);

      default:
        return AlunoAgendaView(
          alunoNome: aluno?['nome']?.toString() ?? 'Aluno',
          atividades: _atividadesAgendadas(aluno),
        );
    }
  }

  List<Map<String, String>> _atividadesAgendadas(
    Map<String, dynamic>? aluno,
  ) {
    final nomesAtribuidos = (aluno?['atividades'] as List?)
            ?.whereType<String>()
            .toSet() ??
        <String>{};

    return atividadesMock
        .where((atividade) => nomesAtribuidos.contains(atividade.nome))
        .map(
          (atividade) => {
            'nome': atividade.nome,
            'horario': atividade.horario,
            'dias': atividade.dias,
            'professor': atividade.professor,
            'local': 'ONG Apoio à Infância',
          },
        )
        .toList();
  }

  Widget _iconeNotificacao(
    IconData icone,
    int quantidade,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icone),

        if (quantidade > 0)
          Positioned(
            right: -9,
            top: -8,
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),

              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),

              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),

              alignment: Alignment.center,

              child: Text(
                quantidade > 99 ? '99+' : '$quantidade',

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class StudentHomeView extends StatelessWidget {
  final String alunoId;

  const StudentHomeView({
    super.key,
    this.alunoId = '001',
  });

  @override
  Widget build(BuildContext context) {
    return AlunoHomeView(alunoId: alunoId);
  }
}