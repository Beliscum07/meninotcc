import 'dart:async';

import 'package:flutter/material.dart';

import '../../controllers/controller/aluno_controller.dart';
import '../../services/aluno_data_service.dart';
import 'widgets/aluno_agenda_view.dart';
import 'widgets/aluno_notificacoes_view.dart';
import 'widgets/aluno_perfil_view.dart';

class AlunoHomeView extends StatefulWidget {
  final String alunoId;

  const AlunoHomeView({super.key, this.alunoId = '001'});

  @override
  State<AlunoHomeView> createState() => _AlunoHomeViewState();
}

class _AlunoHomeViewState extends State<AlunoHomeView> {
  late final AlunoController alunoController;

  int selectedIndex = 0;
  bool _carregandoAluno = true;
  Object? _erroCarregamento;

  @override
  void initState() {
    super.initState();

    alunoController = AlunoController();
    unawaited(alunoController.carregarNotificacoes());
    unawaited(_carregarAluno());
  }

  Future<void> _carregarAluno() async {
    try {
      await AlunoDataService.instance.carregarMeuPerfil(
        idEsperado: widget.alunoId,
      );
      if (mounted) {
        setState(() {
          _carregandoAluno = false;
          _erroCarregamento = null;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _carregandoAluno = false;
          _erroCarregamento = error;
        });
      }
    }
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
          final quantidade = alunoController.quantidadeNotificacoesNaoLidas;

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
                icon: _iconeNotificacao(Icons.notifications_none, quantidade),

                activeIcon: _iconeNotificacao(Icons.notifications, quantidade),

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
    if (_carregandoAluno) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_erroCarregamento != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Não foi possível carregar seus dados do SQL Connect.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  setState(() {
                    _carregandoAluno = true;
                    _erroCarregamento = null;
                  });
                  unawaited(_carregarAluno());
                },
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    final aluno = AlunoDataService.instance.alunoPorId(widget.alunoId);

    switch (selectedIndex) {
      case 0:
        return AlunoAgendaView(
          alunoNome: aluno?['nome']?.toString() ?? 'Aluno',
          atividades: _atividadesAgendadas(aluno),
        );

      case 1:
        return AlunoNotificacoesView(alunoController: alunoController);

      case 2:
        return AlunoPerfilView(alunoId: widget.alunoId);

      default:
        return AlunoAgendaView(
          alunoNome: aluno?['nome']?.toString() ?? 'Aluno',
          atividades: _atividadesAgendadas(aluno),
        );
    }
  }

  List<Map<String, String>> _atividadesAgendadas(Map<String, dynamic>? aluno) {
    final atividades = aluno?['atividadesDetalhes'];
    if (atividades is! List<Map<String, String>>) {
      return const [];
    }
    return atividades;
  }

  Widget _iconeNotificacao(IconData icone, int quantidade) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icone),

        if (quantidade > 0)
          Positioned(
            right: -9,
            top: -8,
            child: Container(
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),

              padding: const EdgeInsets.symmetric(horizontal: 4),

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

  const StudentHomeView({super.key, this.alunoId = '001'});

  @override
  Widget build(BuildContext context) {
    return AlunoHomeView(alunoId: alunoId);
  }
}
