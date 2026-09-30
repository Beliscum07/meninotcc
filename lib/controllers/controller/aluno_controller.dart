import 'package:flutter/foundation.dart';

import '../../models/notificacao_model.dart';

class AlunoController extends ChangeNotifier {
  final List<Notificacao> _notificacoes = [
    Notificacao(
      id: 'aluno_1',
      titulo: 'Nova atividade disponível',
      descricao: 'A atividade de Música e Coral está disponível.',
      tempo: 'Hoje',
      tipo: 'atividade',
    ),
    Notificacao(
      id: 'aluno_2',
      titulo: 'Atividade atualizada',
      descricao: 'O horário da atividade de Arte e Pintura foi alterado.',
      tempo: 'Ontem',
      tipo: 'atividade',
    ),
    Notificacao(
      id: 'aluno_3',
      titulo: 'Aviso da ONG',
      descricao: 'Não se esqueça da atividade desta semana.',
      tempo: '2 dias atrás',
      tipo: 'aviso',
    ),
  ];

  // Retorna todas as notificações.
  List<Notificacao> get notificacoes {
    return List.unmodifiable(_notificacoes);
  }

  // Retorna a quantidade de notificações ainda não lidas.
  int get quantidadeNotificacoesNaoLidas {
    return _notificacoes.where((notificacao) => !notificacao.lida).length;
  }

  // Marca uma notificação específica como lida.
  void marcarNotificacaoComoLida(String id) {
    final index = _notificacoes.indexWhere(
      (notificacao) => notificacao.id == id,
    );

    if (index == -1) {
      return;
    }

    _notificacoes[index].marcarComoLida();

    notifyListeners();
  }

  // Marca todas as notificações como lidas.
  void marcarTodasNotificacoesComoLidas() {
    for (final notificacao in _notificacoes) {
      notificacao.marcarComoLida();
    }

    notifyListeners();
  }

  // Adiciona uma nova notificação.
  void adicionarNotificacao(Notificacao notificacao) {
    _notificacoes.insert(0, notificacao);

    notifyListeners();
  }
}