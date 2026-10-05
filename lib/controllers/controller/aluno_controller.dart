import 'package:flutter/foundation.dart';

import '../../database/mock_database.dart';
import '../../models/notificacao_model.dart';

class AlunoController extends ChangeNotifier {
  final List<Notificacao> _notificacoes;

  AlunoController()
      : _notificacoes = MockDatabase.notificacoes
            .where((item) => item['tipo'] != 'aluno')
            .map(
              (item) => Notificacao(
                id: item['id'] as String,
                titulo: item['titulo'] as String,
                descricao: item['descricao'] as String,
                tempo: item['tempo'] as String,
                tipo: item['tipo'] as String,
                lida: item['lida'] as bool? ?? false,
              ),
            )
            .toList();

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