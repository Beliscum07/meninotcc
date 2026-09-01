import 'package:flutter/material.dart';

// MODELO ATIVIDADE
class Atividade {
  final String nome;
  final String professor;
  final String descricao;
  final String horario;
  final String dias;

  final int inscritos;
  final int vagas;

  final Color cor;

  Atividade({
    required this.nome,
    required this.professor,
    required this.descricao,
    required this.horario,
    required this.dias,
    required this.inscritos,
    required this.vagas,
    required this.cor,
  });
}

// LISTA MOCK DE ATIVIDADES
final List<Atividade> atividadesMock = [
  Atividade(
    nome: 'Música e Coral',
    professor: 'Prof. Carlos Mendes',
    descricao: 'Aulas de canto e prática coral para desenvolvimento musical.',
    horario: '14:00 - 16:00',
    dias: 'Seg, Qua',
    inscritos: 15,
    vagas: 20,
    cor: Color(0xFFE778E8),
  ),
  Atividade(
    nome: 'Arte e Pintura',
    professor: 'Prof. Beatriz Costa',
    descricao: 'Expressão artística através de diferentes técnicas de pintura.',
    horario: '15:00 - 17:00',
    dias: 'Ter, Qui',
    inscritos: 12,
    vagas: 15,
    cor: Color(0xFFF25A0A),
  ),
  Atividade(
    nome: 'Dança e Movimento',
    professor: 'Prof. Amanda Rodrigues',
    descricao: 'Aulas de dança para desenvolvimento motor e expressão corporal.',
    horario: '16:00 - 18:00',
    dias: 'Seg, Sex',
    inscritos: 20,
    vagas: 25,
    cor: Color(0xFFF25A0A),
  ),
  Atividade(
    nome: 'Esportes e Jogos',
    professor: 'Prof. Rafael Santos',
    descricao: 'Atividades esportivas e jogos recreativos.',
    horario: '14:00 - 16:00',
    dias: 'Qua, Sex',
    inscritos: 18,
    vagas: 25,
    cor: Color(0xFFF0A06D),
  ),
];

// CARD DE ATIVIDADE
class CardAtividade extends StatelessWidget {
  final Atividade atividade;
  final VoidCallback onTap;

  const CardAtividade({
    super.key,
    required this.atividade,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ocupacao = atividade.inscritos / atividade.vagas;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: const Color(0xFFD9D9E5),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(21, 20, 21, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: atividade.cor.withOpacity(.10),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: atividade.cor,
                      size: 27,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          atividade.nome,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          atividade.professor,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                atividade.descricao,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_outlined,
                    size: 18,
                    color: Color(0xFF4F52A7),
                  ),
                  const SizedBox(width: 7),
                  Text(atividade.horario),
                  const SizedBox(width: 8),
                  const Text('·'),
                  const SizedBox(width: 8),
                  Text(atividade.dias),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 18,
                    color: Color(0xFF4F52A7),
                  ),
                  const SizedBox(width: 7),
                  Text('${atividade.inscritos} / ${atividade.vagas} vagas'),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: ocupacao,
                  minHeight: 8,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(atividade.cor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Página de Atividades (reutilizável)
class AdminAtividadesPage extends StatelessWidget {
  final List<Atividade>? atividades;

  const AdminAtividadesPage({super.key, this.atividades});

  @override
  Widget build(BuildContext context) {
    final list = atividades ?? atividadesMock;

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final atividade = list[index];
          return CardAtividade(
            atividade: atividade,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(atividade.nome),
                  content: Text(
                    '${atividade.descricao}\n\n${atividade.professor}\n\n${atividade.horario} • ${atividade.dias}\n\n${atividade.inscritos}/${atividade.vagas} vagas',
                  ),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar'))],
                ),
              );
            },
          );
        },
      ),
    );
  }
}