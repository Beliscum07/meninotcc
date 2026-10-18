class Doador {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  double totalDoado;

  Doador({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    this.totalDoado = 0,
  });
}
