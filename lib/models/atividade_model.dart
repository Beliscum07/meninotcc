import 'package:flutter/material.dart';

class Atividade {
  String nome;
  String professor;
  String descricao;
  String horario;
  String dias;
  int inscritos;
  int vagas;
  Color cor;

  Atividade({
    required this.nome,
    required this.professor,
    required this.descricao,
    required this.horario,
    required this.dias,
    required this.inscritos,
    required this.vagas,
    required this.cor,
  });
}

final List<Atividade> atividadesMock = [
  Atividade(
    nome: 'Música e Coral',
    professor: 'Prof. Carlos Mendes',
    descricao:
        'Aulas de canto e prática coral para desenvolvimento musical.',
    horario: '14:00 - 16:00',
    dias: 'Seg, Qua',
    inscritos: 15,
    vagas: 20,
    cor: const Color(0xFFE778E8),
  ),
  Atividade(
    nome: 'Arte e Pintura',
    professor: 'Prof. Beatriz Costa',
    descricao:
        'Expressão artística através de diferentes técnicas de pintura.',
    horario: '15:00 - 17:00',
    dias: 'Ter, Qui',
    inscritos: 12,
    vagas: 15,
    cor: const Color(0xFFF25A0A),
  ),
  Atividade(
    nome: 'Dança e Movimento',
    professor: 'Prof. Amanda Rodrigues',
    descricao:
        'Aulas de dança para desenvolvimento motor e expressão corporal.',
    horario: '16:00 - 18:00',
    dias: 'Seg, Sex',
    inscritos: 20,
    vagas: 25,
    cor: const Color(0xFFF25A0A),
  ),
  Atividade(
    nome: 'Esportes e Jogos',
    professor: 'Prof. Rafael Santos',
    descricao: 'Atividades esportivas e jogos recreativos.',
    horario: '14:00 - 16:00',
    dias: 'Qua, Sex',
    inscritos: 18,
    vagas: 25,
    cor: const Color(0xFFF0A06D),
  ),
];