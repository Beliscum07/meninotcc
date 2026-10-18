class MockDatabase {
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
