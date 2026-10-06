class Atividade {
  final String id;
  final String nome;
  final String professor;
  final String descricao;
  final String horario;
  final String dias;
  final int inscritos;
  final int vagas;
  final String categoria;

  const Atividade({
    required this.id,
    required this.nome,
    required this.professor,
    required this.descricao,
    required this.horario,
    required this.dias,
    required this.inscritos,
    required this.vagas,
    required this.categoria,
  });
}

final List<Atividade> atividadesMock = [
  const Atividade(
    id: 'atv-1',
    nome: 'Arte e Criatividade',
    professor: 'Prof. Ana',
    descricao: 'Atividade lúdica com pintura e criatividade.',
    horario: 'Segunda, 15:30',
    dias: 'Segunda',
    inscritos: 18,
    vagas: 25,
    categoria: 'Cultura',
  ),
  const Atividade(
    id: 'atv-2',
    nome: 'Futebol Comunitário',
    professor: 'Prof. Bruno',
    descricao: 'Aula de esporte em grupo com foco em cooperação.',
    horario: 'Quarta, 16:00',
    dias: 'Quarta',
    inscritos: 22,
    vagas: 30,
    categoria: 'Esporte',
  ),
  const Atividade(
    id: 'atv-3',
    nome: 'Leitura em Grupo',
    professor: 'Prof. Carla',
    descricao: 'Momento de leitura compartilhada e desenvolvimento literacy.',
    horario: 'Quinta, 14:00',
    dias: 'Quinta',
    inscritos: 14,
    vagas: 20,
    categoria: 'Educação',
  ),
];
