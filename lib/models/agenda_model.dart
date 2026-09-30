class AgendaItem {
  final String id;
  final String alunoId;
  final String atividadeId;
  final String atividadeNome;
  final String dia;
  final String horario;

  AgendaItem({
    required this.id,
    required this.alunoId,
    required this.atividadeId,
    required this.atividadeNome,
    required this.dia,
    required this.horario,
  });
}