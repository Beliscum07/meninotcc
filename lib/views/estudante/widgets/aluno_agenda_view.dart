import 'package:flutter/material.dart';

class AlunoAgendaView extends StatefulWidget {
  final String alunoNome;
  final List<Map<String, String>> atividades;

  const AlunoAgendaView({
    super.key,
    this.alunoNome = 'João Pedro',
    this.atividades = const [],
  });

  @override
  State<AlunoAgendaView> createState() => _AlunoAgendaViewState();
}

class _AlunoAgendaViewState extends State<AlunoAgendaView> {
  int diaSelecionado = 1;

  static const List<String> dias = [
    'Dom',
    'Seg',
    'Ter',
    'Qua',
    'Qui',
    'Sex',
    'Sáb',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBDD),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildBoasVindas(),
            _buildDias(),
            Expanded(child: _buildAgenda()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      color: const Color(0xFF565A9A),
      child: const Text(
        'Minha Agenda',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBoasVindas() {
    final quantidadeNaSemana = widget.atividades.fold<int>(
      0,
      (total, atividade) => total + _diasDaAtividade(atividade).length,
    );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC66CE0), Color(0xFF565A9A)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olá, ${widget.alunoNome}!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Você tem $quantidadeNaSemana ${quantidadeNaSemana == 1 ? 'horário' : 'horários'} de atividade nesta semana',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildDias() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: dias.length,
        itemBuilder: (context, index) {
          final selecionado = index == diaSelecionado;

          return GestureDetector(
            onTap: () => setState(() => diaSelecionado = index),
            child: Container(
              width: 82,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: selecionado ? const Color(0xFFD878E8) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF565A9A),
                  width: selecionado ? 0 : 2,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dias[index],
                    style: TextStyle(
                      color: selecionado
                          ? Colors.white
                          : const Color(0xFF333333),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (selecionado)
                    const Icon(Icons.circle, size: 8, color: Colors.white),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAgenda() {
    final dia = dias[diaSelecionado];
    final atividadesDoDia = widget.atividades
        .where((atividade) => _atividadeAconteceNoDia(atividade, dia))
        .toList();

    if (atividadesDoDia.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 60,
              color: Color(0xFF565A9A),
            ),
            SizedBox(height: 15),
            Text(
              'Nenhuma atividade neste dia.',
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: atividadesDoDia.length,
      itemBuilder: (context, index) =>
          _buildAtividade(atividadesDoDia[index]),
    );
  }

  List<String> _diasDaAtividade(Map<String, String> atividade) {
    return (atividade['dias'] ?? '')
        .split(RegExp(r'[,;]'))
        .map((dia) => dia.trim())
        .where((dia) => dia.isNotEmpty)
        .toList();
  }

  bool _atividadeAconteceNoDia(
    Map<String, String> atividade,
    String diaSelecionado,
  ) {
    const prefixos = {
      'Dom': 'dom',
      'Seg': 'seg',
      'Ter': 'ter',
      'Qua': 'qua',
      'Qui': 'qui',
      'Sex': 'sex',
      'Sáb': 'sab',
    };
    final prefixo = prefixos[diaSelecionado];
    if (prefixo == null) {
      return false;
    }

    return _diasDaAtividade(atividade).any((dia) {
      final normalizado = dia
          .toLowerCase()
          .replaceAll('á', 'a')
          .replaceAll('é', 'e')
          .replaceAll('í', 'i')
          .replaceAll('ó', 'o')
          .replaceAll('ú', 'u');
      return normalizado.startsWith(prefixo);
    });
  }

  Widget _buildAtividade(Map<String, String> atividade) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD9D9E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFC56BE0), Color(0xFF565A9A)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  atividade['nome'] ?? 'Atividade',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _detalheAtividade(
            Icons.access_time,
            atividade['horario'] ?? 'Horário não informado',
          ),
          const SizedBox(height: 10),
          _detalheAtividade(
            Icons.calendar_today_outlined,
            'Dias: ${atividade['dias'] ?? 'Não informados'}',
          ),
          const SizedBox(height: 10),
          _detalheAtividade(
            Icons.location_on_outlined,
            atividade['local'] ?? 'Local não informado',
          ),
          const SizedBox(height: 10),
          _detalheAtividade(
            Icons.person_outline,
            atividade['professor'] ?? 'Professor não informado',
          ),
        ],
      ),
    );
  }

  Widget _detalheAtividade(IconData icone, String texto) {
    return Row(
      children: [
        Icon(icone, color: const Color(0xFF565A9A)),
        const SizedBox(width: 8),
        Expanded(child: Text(texto)),
      ],
    );
  }
}