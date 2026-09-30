import 'package:flutter/material.dart';

final List<Notificacao> _notificacoes = [
  Notificacao(
    id: '1',
    titulo: 'Nova atividade disponível',
    descricao: 'A atividade de Música e Coral está disponível.',
    tempo: 'Hoje',
    tipo: 'atividade',
  ),

  Notificacao(
    id: '2',
    titulo: 'Atividade atualizada',
    descricao: 'O horário da atividade de Arte e Pintura foi alterado.',
    tempo: 'Ontem',
    tipo: 'atividade',
  ),

  Notificacao(
    id: '3',
    titulo: 'Aviso da ONG',
    descricao: 'Não se esqueça da atividade desta semana.',
    tempo: '2 dias atrás',
    tipo: 'aviso',
  ),
];
List<Notificacao> get notificacoes => List.unmodifiable(_notificacoes);

// Quantidade de notificações que ainda não foram lidas
int get quantidadeNotificacoesNaoLidas {
  return _notificacoes.where((notificacao) => !notificacao.lida).length;
}

// Marca uma notificação específica como lida
void marcarNotificacaoComoLida(String id) {
  final notificacao = _notificacoes.cast<Notificacao?>().firstWhere(
        (item) => item?.id == id,
        orElse: () => null,
      );

  if (notificacao != null) {
    notificacao.marcarComoLida();
    notifyListeners();
  }
}

// Marca todas como lidas
void marcarTodasNotificacoesComoLidas() {
  for (final notificacao in _notificacoes) {
    notificacao.marcarComoLida();
  }

  notifyListeners();
}

// Adiciona uma nova notificação
void adicionarNotificacao(Notificacao notificacao) {
  _notificacoes.insert(0, notificacao);
  notifyListeners();
}
alunoController.adicionarNotificacao(
  Notificacao(
    id: '4',
    titulo: 'Novo aviso',
    descricao: 'A ONG publicou um novo comunicado.',
    tempo: 'Agora',
    tipo: 'aviso',
  ),
);