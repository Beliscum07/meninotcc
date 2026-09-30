import 'package:flutter/foundation.dart';

import '../../models/notificacao_model.dart';

class AdminController extends ChangeNotifier {
  final List<Notificacao> _notificacoes = [
    Notificacao(
      id: 'admin_1',
      titulo: 'Novo aluno cadastrado',
      descricao: 'Um novo aluno foi cadastrado no sistema.',
      tempo: 'Hoje',
      tipo: 'aluno',
    ),
    Notificacao(
      id: 'admin_2',
      titulo: 'Nova atividade',
      descricao: 'Uma nova atividade foi adicionada ao sistema.',
      tempo: 'Ontem',
      tipo: 'atividade',
    ),
  ];

  List<Notificacao> get notificacoes {
    return List.unmodifiable(_notificacoes);
  }

  int get quantidadeNotificacoesNaoLidas {
    return _notificacoes.where((notificacao) => !notificacao.lida).length;
  }

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

  void marcarTodasNotificacoesComoLidas() {
    for (final notificacao in _notificacoes) {
      notificacao.marcarComoLida();
    }

    notifyListeners();
  }

  void adicionarNotificacao(Notificacao notificacao) {
    _notificacoes.insert(0, notificacao);

    notifyListeners();
  }
}