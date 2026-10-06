enum TipoUsuario { admin, doador, aluno }

class Usuario {
  final String id;
  final String nome;
  final String email;
  final String senha;
  final TipoUsuario tipo;

  const Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipo,
  });
}
