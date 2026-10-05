class MockDatabase {
  static const List<Map<String, dynamic>> usuarios = [
    {
      'id': 'admin-001',
      'nome': 'Administrador',
      'email': 'admin@ong.com',
      'senha': 'admin123',
      'tipo': 'admin',
    },
    {
      'id': 'aluno-001',
      'nome': 'João Pedro',
      'email': 'aluno@ong.com',
      'senha': 'aluno123',
      'tipo': 'aluno',
    },
  ];

  static const List<Map<String, dynamic>> alunos = [
    {
      'id': 'aluno-001',
      'nome': 'João Pedro',
      'idade': 14,
      'responsavel': 'Maria Pedro',
      'telefone': '(11) 98888-1234',
      'email': 'aluno@ong.com',
      'senha': 'aluno123',
      'turma': 'Turma A',
      'atividades': 3,
      'presenca': 92,
      'atividadesInscritas': ['Arte', 'Música', 'Leitura'],
    },
    {
      'id': 'aluno-002',
      'nome': 'Ana Souza',
      'idade': 13,
      'responsavel': 'Carlos Souza',
      'telefone': '(11) 97777-2345',
      'email': 'ana@ong.com',
      'senha': 'ana123',
      'turma': 'Turma B',
      'atividades': 2,
      'presenca': 88,
      'atividadesInscritas': ['Robótica', 'Teatro'],
    },
  ];

  static const List<Map<String, dynamic>> doadores = [
    {
      'id': 'doador-001',
      'nome': 'Doador Teste',
      'email': 'doador@ong.com',
      'senha': 'doador123',
      'telefone': '(16) 99999-0000',
      'totalDoado': 250.0,
    },
    {
      'id': 'doador-002',
      'nome': 'Pedro Almeida',
      'email': 'pedro@ong.com',
      'senha': 'pedro123',
      'telefone': '(16) 98888-1111',
      'totalDoado': 530.0,
    },
  ];

  static const List<Map<String, dynamic>> atividades = [
    {
      'id': 'atv-001',
      'nome': 'Música e Coral',
      'professor': 'Prof. Laura',
      'descricao': 'Aula de canto e expressão corporal.',
      'horario': 'Segunda, 17:00',
      'dias': 'Segunda',
      'inscritos': 20,
      'vagas': 25,
    },
    {
      'id': 'atv-002',
      'nome': 'Arte e Pintura',
      'professor': 'Prof. Carlos',
      'descricao': 'Atividade de pintura, criatividade e expressão.',
      'horario': 'Quarta, 16:00',
      'dias': 'Quarta',
      'inscritos': 18,
      'vagas': 20,
    },
    {
      'id': 'atv-003',
      'nome': 'Robótica',
      'professor': 'Prof. Renan',
      'descricao': 'Desenvolvimento de projetos e lógica.',
      'horario': 'Terça, 15:30',
      'dias': 'Terça',
      'inscritos': 14,
      'vagas': 18,
    },
    {
      'id': 'atv-004',
      'nome': 'Leitura e Escrita',
      'professor': 'Prof. Beatriz',
      'descricao': 'Leitura compartilhada e produção textual.',
      'horario': 'Quinta, 14:00',
      'dias': 'Quinta',
      'inscritos': 16,
      'vagas': 22,
    },
  ];

  static const List<Map<String, dynamic>> agenda = [
    {
      'id': 'agenda-001',
      'alunoId': 'aluno-001',
      'atividadeId': 'atv-001',
      'atividadeNome': 'Música e Coral',
      'dia': 'Segunda',
      'horario': '17:00',
    },
    {
      'id': 'agenda-002',
      'alunoId': 'aluno-001',
      'atividadeId': 'atv-002',
      'atividadeNome': 'Arte e Pintura',
      'dia': 'Quarta',
      'horario': '16:00',
    },
    {
      'id': 'agenda-003',
      'alunoId': 'aluno-002',
      'atividadeId': 'atv-003',
      'atividadeNome': 'Robótica',
      'dia': 'Terça',
      'horario': '15:30',
    },
  ];

  static const List<Map<String, dynamic>> notificacoes = [
    {
      'id': 'notif-001',
      'titulo': 'Nova atividade disponível',
      'descricao': 'A atividade de Música e Coral está disponível.',
      'tempo': 'Hoje',
      'tipo': 'atividade',
      'lida': false,
    },
    {
      'id': 'notif-002',
      'titulo': 'Atividade atualizada',
      'descricao': 'O horário da atividade de Arte e Pintura foi alterado.',
      'tempo': 'Ontem',
      'tipo': 'atividade',
      'lida': false,
    },
    {
      'id': 'notif-003',
      'titulo': 'Aviso da ONG',
      'descricao': 'Não se esqueça da atividade desta semana.',
      'tempo': '2 dias atrás',
      'tipo': 'aviso',
      'lida': true,
    },
    {
      'id': 'notif-004',
      'titulo': 'Novo aluno cadastrado',
      'descricao': 'Um novo aluno foi cadastrado no sistema.',
      'tempo': 'Hoje',
      'tipo': 'aluno',
      'lida': false,
    },
  ];

  static const List<Map<String, dynamic>> donationHistory = [
    {'date': '10/08/2026', 'amount': 150.00},
    {'date': '15/07/2026', 'amount': 200.00},
    {'date': '22/06/2026', 'amount': 310.00},
  ];

  static const List<Map<String, dynamic>> studentActivities = [
    {'title': 'Dança', 'progress': 0.8},
    {'title': 'Música', 'progress': 0.5},
    {'title': 'Esporte', 'progress': 0.9},
  ];
}