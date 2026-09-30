class Doador {
  final String id;

  String nome;
  String email;
  String senha;
  String telefone;

  double totalDoado;

  Doador({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    this.telefone = '',
    this.totalDoado = 0.0,
  });

  Doador copyWith({
    String? id,
    String? nome,
    String? email,
    String? senha,
    String? telefone,
    double? totalDoado,
  }) {
    return Doador(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      telefone: telefone ?? this.telefone,
      totalDoado: totalDoado ?? this.totalDoado,
    );
  }
}