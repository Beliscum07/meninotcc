import 'package:flutter/foundation.dart';

import '../../database/mock_database.dart';
import '../../models/notificacao_model.dart';

class AdminController extends ChangeNotifier {
  final List<Notificacao> _notificacoes;

  AdminController()
      : _notificacoes = MockDatabase.notificacoes
            .where(
                (item) => item['tipo'] == 'aluno' || item['tipo'] == 'atividade')
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

  List<Notificacao> get notificacoes => List.unmodifiable(_notificacoes);

  int get quantidadeNotificacoesNaoLidas =>
      _notificacoes.where((notificacao) => !notificacao.lida).length;

  void marcarNotificacaoComoLida(String id) {
    final index = _notificacoes.indexWhere((notificacao) => notificacao.id == id);
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