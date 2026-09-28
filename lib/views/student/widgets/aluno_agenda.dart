import 'package:flutter/material.dart';

class StudentAgenda extends StatelessWidget {
  const StudentAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Agenda'));
  }
}

class AlunoAgendaView extends StatefulWidget {
  const AlunoAgendaView({super.key});

  @override
  State<AlunoAgendaView> createState() => _AlunoAgendaViewState();
}

class _AlunoAgendaViewState extends State<AlunoAgendaView> {
  int diaSelecionado = 1;

  final List<String> dias = [
    'Dom',
    'Seg',
    'Ter',
    'Qua',
    'Qui',
    'Sex',
    'Sáb',
  ];

  final Map<int, String> nomesDias = {
    0: 'Domingo',
    1: 'Segunda',
    2: 'Terça',
    3: 'Quarta',
    4: 'Quinta',
    5: 'Sexta',
    6: 'Sábado',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EADB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5056AC),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Minha Agenda',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_none,
                  size: 32,
                ),
                Positioned(
                  right: -8,
                  top: -8,
                  child: Container(
                    width: 27,
                    height: 27,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFD277E2),
                    Color(0xFF5557AC),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá, João Pedro! 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Você tem 4 atividades esta semana',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 105,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: dias.length,
                itemBuilder: (context, index) {
                  final selecionado = diaSelecionado == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        diaSelecionado = index;
                      });
                    },
                    child: Container(
                      width: 85,
                      margin: const EdgeInsets.only(right: 9),
                      decoration: BoxDecoration(
                        color: selecionado
                            ? const Color(0xFFE17BEA)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: selecionado
                              ? const Color(0xFFE17BEA)
                              : const Color(0xFF5056AC),
                          width: selecionado ? 1 : 2,
                        ),
                        boxShadow: selecionado
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dias[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: selecionado
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: selecionado
                                  ? Colors.white
                                  : const Color(0xFF444444),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (selecionado)
                            const Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 10,
                            )
                          else if (index == 3 || index == 5)
                            const Icon(
                              Icons.circle,
                              color: Color(0xFFE17BEA),
                              size: 10,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                nomesDias[diaSelecionado]!,
                style: const TextStyle(
                  color: Color(0xFF5056AC),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (diaSelecionado == 1)
              _atividade(
                titulo: 'Música e Coral',
                horario: '14:00 - 16:00',
                local: 'Sala de Música',
                professor: 'Prof. Carlos Mendes',
              )
            else
              _semAtividades(),
          ],
        ),
      ),
    );
  }

  Widget _atividade({
    required String titulo,
    required String horario,
    required String local,
    required String professor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE1E1E1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFD277E2),
                  Color(0xFF6657B7),
                ],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.calendar_month,
              color: Colors.white,
              size: 38,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _informacao(
                  Icons.access_time,
                  horario,
                ),
                _informacao(
                  Icons.location_on_outlined,
                  local,
                ),
                _informacao(
                  Icons.person_outline,
                  professor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _informacao(
    IconData icone,
    String texto,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icone,
            color: const Color(0xFF5056AC),
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              texto,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF555555),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _semAtividades() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Center(
        child: Text(
          'Nenhuma atividade neste dia.',
          style: TextStyle(
            fontSize: 19,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
