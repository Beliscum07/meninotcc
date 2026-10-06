class Aluno {
  final String id;
  final String nome;
  final int idade;
  final String responsavel;
  final String telefone;
  final int presenca;
  final List<String> atividades;
  final List<String> bolsas;

  const Aluno({
    required this.id,
    required this.nome,
    required this.idade,
    required this.responsavel,
    required this.telefone,
    required this.presenca,
    required this.atividades,
    required this.bolsas,
  });
}
