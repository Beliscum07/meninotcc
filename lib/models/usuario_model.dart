import 'package:flutter/material.dart';

enum TipoUsuario {
  admin,
  aluno,
  doador,
}

class Usuario {
  final String id;
  String nome;
  String email;
  String senha;
  final TipoUsuario tipo;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.tipo,
  });

  Usuario copyWith({
    String? id,
    String? nome,
    String? email,
    String? senha,
    TipoUsuario? tipo,
  }) {
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      tipo: tipo ?? this.tipo,
    );
  }
}