import 'package:flutter/foundation.dart';

import 'auth_service.dart';
import 'sql_connect_service.dart';

class AlunoDataService extends ChangeNotifier {
  AlunoDataService._();

  static final AlunoDataService instance = AlunoDataService._();

  final List<Map<String, dynamic>> alunos = [];

  Map<String, dynamic>? alunoPorId(String id) {
    for (final aluno in alunos) {
      if (aluno['id'] == id) {
        return aluno;
      }
    }
    return null;
  }

  Future<void> carregarMeuPerfil({required String idEsperado}) async {
    final aluno = await SqlConnectService.instance.buscarMeuPerfilAluno();
    if (aluno == null || aluno.id != idEsperado) {
      throw const AuthProfileException(
        'O cadastro de estudante não corresponde à sessão autenticada.',
      );
    }

    final atividades = aluno.inscricoes_on_aluno
        .map((inscricao) => inscricao.atividade)
        .toList();
    final bolsas = aluno.alunoBolsas_on_aluno
        .map((atribuicao) => atribuicao.bolsa)
        .toList();

    alunos
      ..clear()
      ..add(
        _mapearAluno(
          id: aluno.id,
          nome: aluno.nome,
          idade: aluno.idade,
          responsavel: aluno.responsavel,
          telefone: aluno.telefone,
          email: aluno.email,
          presenca: aluno.presenca,
          atividades: [
            for (final atividade in atividades)
              {'id': atividade.id, 'nome': atividade.nome},
          ],
          bolsas: [
            for (final bolsa in bolsas) {'id': bolsa.id, 'nome': bolsa.nome},
          ],
          atividadesDetalhes: [
            for (final atividade in atividades)
              {
                'nome': atividade.nome,
                'horario': atividade.horario ?? '',
                'dias': atividade.dias ?? '',
                'professor': atividade.professor,
                'local': 'ONG Menino Barsanulfo',
              },
          ],
        ),
      );
    notifyListeners();
  }

  Future<void> carregarAlunosAdministrativos() async {
    final registros = await SqlConnectService.instance.listarAlunos();
    alunos
      ..clear()
      ..addAll(
        registros.map((aluno) {
          final atividades = aluno.inscricoes_on_aluno
              .map((inscricao) => inscricao.atividade)
              .toList();
          final bolsas = aluno.alunoBolsas_on_aluno
              .map((atribuicao) => atribuicao.bolsa)
              .toList();
          return _mapearAluno(
            id: aluno.id,
            nome: aluno.nome,
            idade: aluno.idade,
            responsavel: aluno.responsavel,
            telefone: aluno.telefone,
            email: aluno.email,
            presenca: aluno.presenca,
            usuarioUid: aluno.usuarioUid,
            status: aluno.status,
            atividades: [
              for (final atividade in atividades)
                {'id': atividade.id, 'nome': atividade.nome},
            ],
            bolsas: [
              for (final bolsa in bolsas) {'id': bolsa.id, 'nome': bolsa.nome},
            ],
            atividadesDetalhes: const [],
          );
        }),
      );
    notifyListeners();
  }

  Map<String, dynamic> _mapearAluno({
    required String id,
    required String nome,
    required int idade,
    required String responsavel,
    required String telefone,
    required String? email,
    required int presenca,
    String? usuarioUid,
    String status = 'ativo',
    required List<Map<String, String>> atividades,
    required List<Map<String, String>> bolsas,
    required List<Map<String, String>> atividadesDetalhes,
  }) {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'responsavel': responsavel,
      'telefone': telefone,
      'email': email ?? '',
      'presenca': presenca,
      'usuarioUid': usuarioUid,
      'status': status,
      'atividades': atividades.map((atividade) => atividade['nome']!).toList(),
      'atividadeIds': {
        for (final atividade in atividades)
          atividade['nome']!: atividade['id']!,
      },
      'bolsas': bolsas.map((bolsa) => bolsa['nome']!).toList(),
      'bolsaIds': {for (final bolsa in bolsas) bolsa['nome']!: bolsa['id']!},
      'atividadesDetalhes': atividadesDetalhes,
    };
  }

  void notificarAlteracao() {
    notifyListeners();
  }
}
