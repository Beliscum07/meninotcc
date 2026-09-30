import 'package:flutter/material.dart';

import '../../../controllers/controller/aluno_controller.dart';
import '../../../models/notificacao_model.dart';

class AlunoNotificacoesView extends StatelessWidget {
  final AlunoController alunoController;

  const AlunoNotificacoesView({
    super.key,
    required this.alunoController,
  });

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
          ListenableBuilder(
            listenable: alunoController,

            builder: (context, child) {
              final existemNaoLidas =
                  alunoController.quantidadeNotificacoesNaoLidas > 0;

              return TextButton(
                onPressed: existemNaoLidas
                    ? alunoController.marcarTodasNotificacoesComoLidas
                    : null,

                child: Text(
                  'Marcar tudo como lido',

                  style: TextStyle(
                    color: existemNaoLidas
                        ? Colors.white
                        : Colors.white54,

                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: ListenableBuilder(
        listenable: alunoController,

        builder: (context, child) {
          final notificacoes = alunoController.notificacoes;

          if (notificacoes.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma notificação.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20,
            ),

            itemCount: notificacoes.length,

            itemBuilder: (context, index) {
              final notificacao = notificacoes[index];

              return _notificacao(
                notificacao,
              );
            },
          );
        },
      ),
    );
  }

  Widget _notificacao(
    Notificacao notificacao,
  ) {
    final icone = _iconePorTipo(notificacao.tipo);
    final cor = _corIcone(notificacao.tipo);

    return InkWell(
      onTap: () {
        alunoController.marcarNotificacaoComoLida(
          notificacao.id,
        );
      },

      child: Container(
        margin: const EdgeInsets.fromLTRB(
          12,
          0,
          12,
          18,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 22,
        ),

        decoration: BoxDecoration(
          color: notificacao.lida
              ? const Color(0xFFF8F6F3)
              : Colors.white,

          borderRadius: BorderRadius.circular(22),

          border: Border.all(
            color: notificacao.lida
                ? const Color(0xFFE0DDD9)
                : const Color(0xFFE17BEA),

            width: notificacao.lida ? 1 : 1.5,
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
                color: cor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),

              child: Icon(
                icone,
                color: cor,
                size: 28,
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Expanded(
                        child: Text(
                          notificacao.titulo,

                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: notificacao.lida
                                ? FontWeight.w600
                                : FontWeight.bold,
                          ),
                        ),
                      ),

                      if (!notificacao.lida)
                        Container(
                          width: 9,
                          height: 9,

                          margin: const EdgeInsets.only(
                            left: 8,
                            top: 5,
                          ),

                          decoration: const BoxDecoration(
                            color: Color(0xFFE17BEA),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    notificacao.descricao,

                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    notificacao.tempo,

                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconePorTipo(String tipo) {
    switch (tipo) {
      case 'atividade':
        return Icons.local_activity_outlined;

      case 'evento':
        return Icons.event_outlined;

      case 'aviso':
        return Icons.campaign_outlined;

      case 'aluno':
        return Icons.person_outline;

      default:
        return Icons.notifications_none;
    }
  }

  Color _corIcone(String tipo) {
    switch (tipo) {
      case 'atividade':
        return const Color(0xFF5B61C8);

      case 'evento':
        return const Color(0xFF4CAF50);

      case 'aviso':
        return const Color(0xFFFF9800);

      case 'aluno':
        return const Color(0xFFE17BEA);

      default:
        return const Color(0xFF5B61C8);
    }
  }
}