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
    this.cor = const Color(0xFFE778E8),
  });
}

final List<Atividade> atividadesMock = [
  Atividade(
    id: 'atv-1',
    nome: 'Arte e Criatividade',
    professor: 'Prof. Ana',
    descricao: 'Atividade lúdica com pintura e criatividade.',
    horario: 'Segunda, 15:30',
    dias: 'Segunda',
    inscritos: 18,
    vagas: 25,
    categoria: 'Cultura',
    cor: const Color(0xFFE778E8),
  ),
  Atividade(
    id: 'atv-2',
    nome: 'Futebol Comunitário',
    professor: 'Prof. Bruno',
    descricao: 'Aula de esporte em grupo com foco em cooperação.',
    horario: 'Quarta, 16:00',
    dias: 'Quarta',
    inscritos: 22,
    vagas: 30,
    categoria: 'Esporte',
    cor: const Color(0xFF66BB6A),
  ),
  Atividade(
    id: 'atv-3',
    nome: 'Leitura em Grupo',
    professor: 'Prof. Carla',
    descricao: 'Momento de leitura compartilhada e desenvolvimento literacy.',
    horario: 'Quinta, 14:00',
    dias: 'Quinta',
    inscritos: 14,
    vagas: 20,
    categoria: 'Educação',
    cor: const Color(0xFF42A5F5),
  ),
];
