class Notificacao {
  final String id;
  final String titulo;
  final String descricao;
  final String tempo;
  final String tipo;
  bool lida;

  Notificacao({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.tempo,
    required this.tipo,
    this.lida = false,
  });

  void marcarComoLida() {
    lida = true;
  }
}
