import 'package:flutter/material.dart';
import '../../../models/student_model.dart';

class CardAluno extends StatelessWidget {
  final Aluno aluno;

  final VoidCallback onDetalhes;
  final VoidCallback onEditar;

  const CardAluno({
    super.key,
    required this.aluno,
    required this.onDetalhes,
    required this.onEditar,
  });

  @override
  Widget build(BuildContext context) {
    final inicial = aluno.nome.isNotEmpty ? aluno.nome[0].toUpperCase() : '?';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFD9D9E5)),
        boxShadow: const [
          BoxShadow(color: Color(0x22000000), blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFD778E8), Color(0xFF5551AA)],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(inicial, style: const TextStyle(color: Colors.white, fontSize: 25)),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(aluno.nome, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('${aluno.idade} anos · ID: ${aluno.id}', style: const TextStyle(fontSize: 14, color: Colors.black54)),
                      const SizedBox(height: 9),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 15, color: Color(0xFF4F52A7)),
                          const SizedBox(width: 5),
                          Text('${aluno.atividades} atividades', style: const TextStyle(fontSize: 13)),
                          const SizedBox(width: 18),
                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                          const SizedBox(width: 5),
                          Text('${aluno.presenca}% presença', style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 28),

            Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(children: [
                  const TextSpan(text: 'Responsável: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: aluno.responsavel),
                  TextSpan(text: '\n${aluno.telefone}'),
                ]),
                style: const TextStyle(fontSize: 13),
              ),
            ),

            const SizedBox(height: 13),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDetalhes,
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF4D50B0), width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    child: const Text('Detalhes', style: TextStyle(color: Color(0xFF4D50B0))),
                  ),
                ),

                const SizedBox(width: 25),

                TextButton(onPressed: onEditar, child: const Text('Editar', style: TextStyle(color: Color(0xFF4D50B0)))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
