import 'package:flutter/material.dart';

class AlunoNotificacoesView extends StatefulWidget {
  const AlunoNotificacoesView({super.key});

  @override
  State<AlunoNotificacoesView> createState() =>
      _AlunoNotificacoesViewState();
}

class _AlunoNotificacoesViewState
    extends State<AlunoNotificacoesView> {
  bool todasLidas = false;

  final List<Map<String, dynamic>> notificacoes = [
    {
      'titulo': 'Lembrete: Aula de Música',
      'descricao': 'Sua aula começa em 30 minutos!',
      'tempo': 'há 4 meses',
      'icone': Icons.priority_high,
      'lida': false,
    },
    {
      'titulo': 'Novo horário disponível',
      'descricao':
          'Abertas inscrições para aula de teatro às quartas-feiras!',
      'tempo': 'há 4 meses',
      'icone': Icons.campaign_outlined,
      'lida': false,
    },
    {
      'titulo': 'Aula cancelada',
      'descricao':
          'A aula de esportes de hoje foi cancelada devido à chuva.',
      'tempo': 'há 4 meses',
      'icone': Icons.event_busy_outlined,
      'lida': true,
    },
    {
      'titulo': 'Evento especial',
      'descricao':
          'Apresentação de fim de semestre dia 25/06. Marque na agenda!',
      'tempo': 'há 4 meses',
      'icone': Icons.campaign_outlined,
      'lida': true,
    },
  ];

  void marcarTodasComoLidas() {
    setState(() {
      todasLidas = true;

      for (final notificacao in notificacoes) {
        notificacao['lida'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EADB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5056AC),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notificações',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: marcarTodasComoLidas,
            child: const Text(
              'Marcar tudo como lido',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 20,
        ),
        itemCount: notificacoes.length,
        itemBuilder: (context, index) {
          final notificacao = notificacoes[index];
          final bool lida = notificacao['lida'];

          return _notificacao(
            titulo: notificacao['titulo'],
            descricao: notificacao['descricao'],
            tempo: notificacao['tempo'],
            icone: notificacao['icone'],
            lida: lida,
          );
        },
      ),
    );
  }

  Widget _notificacao({
    required String titulo,
    required String descricao,
    required String tempo,
    required IconData icone,
    required bool lida,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 18),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 26,
      ),
      decoration: BoxDecoration(
        color: lida ? const Color(0xFFF8F6F3) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: lida ? const Color(0xFFE0DDD9) : const Color(0xFFE17BEA),
          width: lida ? 1 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _corIcone(icone).withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icone,
              color: _corIcone(icone),
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: lida
                        ? const Color(0xFF666666)
                        : const Color(0xFF111111),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  descricao,
                  style: TextStyle(
                    fontSize: 18,
                    color: lida
                        ? const Color(0xFF999999)
                        : const Color(0xFF555555),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  tempo,
                  style: TextStyle(
                    fontSize: 16,
                    color: lida
                        ? const Color(0xFF999999)
                        : const Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _corIcone(IconData icone) {
    if (icone == Icons.event_busy_outlined) {
      return const Color(0xFFFF7B3D);
    }

    if (icone == Icons.priority_high) {
      return const Color(0xFFE17BEA);
    }

    return const Color(0xFF5056AC);
  }
}
