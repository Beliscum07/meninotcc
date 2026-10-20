import 'package:flutter/foundation.dart';

import '../../models/notificacao_model.dart';
import '../../services/sql_connect_service.dart';

class AdminController extends ChangeNotifier {
  final List<Notificacao> _notificacoes = [];
  bool carregando = true;
  Object? erro;

  List<Notificacao> get notificacoes => List.unmodifiable(_notificacoes);

  int get quantidadeNotificacoesNaoLidas =>
      _notificacoes.where((notificacao) => !notificacao.lida).length;

  Future<void> carregarNotificacoes() async {
    carregando = true;
    erro = null;
    notifyListeners();
    try {
      final registros = await SqlConnectService.instance.minhasNotificacoes();
      _notificacoes
        ..clear()
        ..addAll(
          registros.map((registro) {
            final data = registro.dataCriacao.toDateTime().toLocal();
            return Notificacao(
              id: registro.id,
              titulo: registro.titulo,
              descricao: registro.mensagem,
              tempo:
                  '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}',
              tipo: 'aviso',
              lida: registro.lida,
            );
          }),
        );
    } catch (error, stackTrace) {
      debugPrint(
        'Falha ao carregar notificações administrativas: $error\n$stackTrace',
      );
      erro = error;
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<void> marcarNotificacaoComoLida(String id) async {
    final index = _notificacoes.indexWhere(
      (notificacao) => notificacao.id == id,
    );
    if (index == -1 || _notificacoes[index].lida) return;

    try {
      await SqlConnectService.instance.marcarNotificacaoComoLida(id);
      _notificacoes[index].marcarComoLida();
      notifyListeners();
    } catch (error, stackTrace) {
      debugPrint(
        'Falha ao marcar notificação administrativa como lida: $error\n$stackTrace',
      );
      erro = error;
      notifyListeners();
    }
  }

  Future<void> marcarTodasNotificacoesComoLidas() async {
    try {
      await Future.wait(
        _notificacoes
            .where((notificacao) => !notificacao.lida)
            .map(
              (notificacao) => SqlConnectService.instance
                  .marcarNotificacaoComoLida(notificacao.id),
            ),
      );
      for (final notificacao in _notificacoes) {
        notificacao.marcarComoLida();
      }
      erro = null;
    } catch (error, stackTrace) {
      debugPrint(
        'Falha ao marcar notificações administrativas como lidas: $error\n$stackTrace',
      );
      erro = error;
    }
    notifyListeners();
  }
}
