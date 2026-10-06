import 'package:flutter/foundation.dart';

class AlunoDataService extends ChangeNotifier {
  AlunoDataService._();

  static final AlunoDataService instance = AlunoDataService._();

  final List<Map<String, dynamic>> alunos = [
    {
      'id': '001',
      'nome': 'João Pedro',
      'idade': 18,
      'responsavel': 'Maria Pedro',
      'telefone': '(16) 99999-1111',
      'presenca': 92,
      'atividades': <String>[],
      'bolsas': <String>['Bolsa Educação Integral'],
    },
    {
      'id': '002',
      'nome': 'Lucas Silva',
      'idade': 15,
      'responsavel': 'Ana Silva',
      'telefone': '(16) 99999-2222',
      'presenca': 88,
      'atividades': <String>[],
      'bolsas': <String>['Bolsa Esporte e Cultura'],
    },
    {
      'id': '003',
      'nome': 'Mariana Souza',
      'idade': 16,
      'responsavel': 'Carlos Souza',
      'telefone': '(16) 99999-3333',
      'presenca': 95,
      'atividades': <String>[],
      'bolsas': <String>[],
    },
  ];

  Map<String, dynamic>? alunoPorId(String id) {
    for (final aluno in alunos) {
      if (aluno['id'] == id) {
        return aluno;
      }
    }
    return null;
  }

  String idDoAlunoSelecionado({String? id, String? nome}) {
    if (id != null && alunoPorId(id) != null) {
      return id;
    }

    if (nome != null) {
      final nomeNormalizado = nome.trim().toLowerCase();
      for (final aluno in alunos) {
        final nomeAluno = aluno['nome'].toString().toLowerCase();
        if (nomeAluno == nomeNormalizado ||
            nomeAluno.startsWith(nomeNormalizado) ||
            nomeNormalizado.startsWith(nomeAluno)) {
          return aluno['id'].toString();
        }
      }
    }

    return alunos.first['id'].toString();
  }

  void notificarAlteracao() {
    notifyListeners();
  }
}