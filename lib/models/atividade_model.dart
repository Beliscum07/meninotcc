import 'package:flutter/material.dart';

class Atividade {
  String id;
  String nome;
  String professor;
  String descricao;
  String horario;
  String dias;
  int inscritos;
  int vagas;
  String categoria;
  String status;
  Color cor;

  Atividade({
    required this.id,
    required this.nome,
    required this.professor,
    required this.descricao,
    required this.horario,
    required this.dias,
    required this.inscritos,
    required this.vagas,
    required this.categoria,
    this.status = 'ativa',
    this.cor = const Color(0xFFE778E8),
  });
}

final List<Atividade> atividadesMock = [];
