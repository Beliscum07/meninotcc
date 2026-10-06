class MockDatabase {
  static const List<Map<String, dynamic>> usuarios = [
    {
      'id': 'admin-1',
      'nome': 'Administrador ONG',
      'email': 'admin@ong.com',
      'senha': 'admin123',
      'tipo': 'admin',
    },
    {
      'id': 'aluno-1',
      'nome': 'Aluno Teste',
      'email': 'aluno@ong.com',
      'senha': 'aluno123',
      'tipo': 'aluno',
    },
  ];

  static const List<Map<String, dynamic>> doadores = [
    {
      'id': 'doador-1',
      'nome': 'Doador Teste',
      'email': 'doador@ong.com',
      'senha': 'doador123',
      'telefone': '(16) 99999-0000',
      'totalDoado': 120.0,
    },
  ];

  static const List<Map<String, dynamic>> notificacoes = [
    {
      'id': 'noti-1',
      'titulo': 'Nova atividade disponível',
      'descricao': 'A atividade de teatro foi aberta para inscrição.',
      'tempo': '2h atrás',
      'tipo': 'aluno',
      'lida': false,
    },
    {
      'id': 'noti-2',
      'titulo': 'Doação recebida',
      'descricao': 'Seu apoio foi registrado com sucesso.',
      'tempo': 'Hoje',
      'tipo': 'doador',
      'lida': true,
    },
    {
      'id': 'noti-3',
      'titulo': 'Acompanhamento semanal',
      'descricao': 'Confira o resumo semanal dos alunos assistidos.',
      'tempo': '1 dia atrás',
      'tipo': 'atividade',
      'lida': false,
    },
  ];
}
