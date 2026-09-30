class Aluno {
  final String id;

  String nome;
  int idade;
  String responsavel;
  String telefone;
  String email;
  String senha;
  String turma;

  int atividades;
  int presenca;

  List<String> atividadesInscritas;

  Aluno({
    required this.id,
    required this.nome,
    required this.idade,
    required this.responsavel,
    required this.telefone,
    required this.email,
    required this.senha,
    this.turma = '',
    this.atividades = 0,
    this.presenca = 0,
    List<String>? atividadesInscritas,
  }) : atividadesInscritas = atividadesInscritas ?? [];

  Aluno copyWith({
    String? id,
    String? nome,
    int? idade,
    String? responsavel,
    String? telefone,
    String? email,
    String? senha,
    String? turma,
    int? atividades,
    int? presenca,
    List<String>? atividadesInscritas,
  }) {
    return Aluno(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
      responsavel: responsavel ?? this.responsavel,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      turma: turma ?? this.turma,
      atividades: atividades ?? this.atividades,
      presenca: presenca ?? this.presenca,
      atividadesInscritas: atividadesInscritas ??
          List<String>.from(this.atividadesInscritas),
    );
  }
}