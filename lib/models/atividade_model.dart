class Atividade {
  final String id;

  String nome;
  String professor;
  String descricao;
  String horario;
  String dias;

  int inscritos;
  int vagas;

  Atividade({
    required this.id,
    required this.nome,
    required this.professor,
    required this.descricao,
    required this.horario,
    required this.dias,
    this.inscritos = 0,
    this.vagas = 0,
  });

  bool get possuiVaga {
    return inscritos < vagas;
  }

  Atividade copyWith({
    String? id,
    String? nome,
    String? professor,
    String? descricao,
    String? horario,
    String? dias,
    int? inscritos,
    int? vagas,
  }) {
    return Atividade(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      professor: professor ?? this.professor,
      descricao: descricao ?? this.descricao,
      horario: horario ?? this.horario,
      dias: dias ?? this.dias,
      inscritos: inscritos ?? this.inscritos,
      vagas: vagas ?? this.vagas,
    );
  }
}