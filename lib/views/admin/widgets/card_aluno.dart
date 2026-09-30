import 'package:flutter/material.dart';

import '../../../models/student_model.dart';

class CardAluno extends StatelessWidget {
  final Aluno aluno;

  final VoidCallback onDetalhes;
  final VoidCallback onEditar;
  final VoidCallback onExcluir;

  const CardAluno({
    super.key,
    required this.aluno,
    required this.onDetalhes,
    required this.onEditar,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    final inicial =
        aluno.nome.isNotEmpty
            ? aluno.nome[0].toUpperCase()
            : '?';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFD9D9E5),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Container(
                  width: 56,
                  height: 56,

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,

                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFD778E8),
                        Color(0xFF5551AA),
                      ],
                    ),
                  ),

                  alignment: Alignment.center,

                  child: Text(
                    inicial,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        aluno.nome,

                        maxLines: 2,

                        overflow:
                            TextOverflow.ellipsis,

                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        '${aluno.idade} anos · ID: ${aluno.id}',

                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '${aluno.atividades} atividades · '
                        '${aluno.presenca}% presença',

                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 28),

            Align(
              alignment: Alignment.centerLeft,

              child: Text(
                'Responsável: ${aluno.responsavel}\n'
                '${aluno.telefone}',

                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 13),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDetalhes,

                    child: const Text(
                      'Detalhes',
                      style: TextStyle(
                        color: Color(0xFF4D50B0),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                IconButton(
                  tooltip: 'Editar',
                  onPressed: onEditar,

                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF4D50B0),
                  ),
                ),

                IconButton(
                  tooltip: 'Excluir',
                  onPressed: onExcluir,

                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}