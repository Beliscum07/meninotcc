class Doador {
  final String id;
  final String nome;
  final String email;
  final String senha;
  final String telefone;
  double totalDoado;

  Doador({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.telefone,
    this.totalDoado = 0,
  });
}
