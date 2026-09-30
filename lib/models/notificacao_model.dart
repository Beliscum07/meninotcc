import 'package:flutter/material.dart';

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

  // Marca a notificação como lida
  void marcarComoLida() {
    lida = true;
  }

  // Cria uma cópia da notificação
  Notificacao copyWith({
    String? id,
    String? titulo,
    String? descricao,
    String? tempo,
    String? tipo,
    bool? lida,
  }) {
    return Notificacao(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      tempo: tempo ?? this.tempo,
      tipo: tipo ?? this.tipo,
      lida: lida ?? this.lida,
    );
  }
}