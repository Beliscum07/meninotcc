import 'package:flutter/material.dart';

import '../../../controllers/controller/admin_controller.dart';
import '../../../models/notificacao_model.dart';

class AdminNotificacoesView extends StatelessWidget {
  final AdminController adminController;

  const AdminNotificacoesView({
    super.key,
    required this.adminController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF5558AD),
        foregroundColor: Colors.white,

        title: const Text(
          'Notificações',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          ListenableBuilder(
            listenable: adminController,

            builder: (context, child) {
              final temNaoLidas =
                  adminController.quantidadeNotificacoesNaoLidas > 0;

              return TextButton(
                onPressed: temNaoLidas
                    ? adminController.marcarTodasNotificacoesComoLidas
                    : null,

                child: Text(
                  'Marcar todas',

                  style: TextStyle(
                    color: temNaoLidas
                        ? Colors.white
                        : Colors.white54,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: ListenableBuilder(
        listenable: adminController,

        builder: (context, child) {
          final notificacoes =
              adminController.notificacoes;

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
            padding: const EdgeInsets.all(16),

            itemCount: notificacoes.length,

            itemBuilder: (context, index) {
              return _card(
                notificacoes[index],
              );
            },
          );
        },
      ),
    );
  }

  Widget _card(Notificacao notificacao) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),

      onTap: () {
        adminController.marcarNotificacaoComoLida(
          notificacao.id,
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: notificacao.lida
              ? Colors.white
              : const Color(0xFFFFF9FF),

          borderRadius: BorderRadius.circular(16),

          border: Border.all(
            color: notificacao.lida
                ? const Color(0xFFE0E0E0)
                : const Color(0xFFC56BE0),
          ),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(
                color: const Color(0xFFC56BE0)
                    .withOpacity(0.12),

                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.notifications_outlined,
                color: Color(0xFFC56BE0),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notificacao.titulo,

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: notificacao.lida
                                ? FontWeight.w500
                                : FontWeight.bold,
                          ),
                        ),
                      ),

                      if (!notificacao.lida)
                        Container(
                          width: 9,
                          height: 9,

                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  Text(
                    notificacao.descricao,

                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 8),

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
}