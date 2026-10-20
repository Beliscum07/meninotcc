part of 'example.dart';

class ListStudentsVariablesBuilder {
  final FirebaseDataConnect _dataConnect;
  ListStudentsVariablesBuilder(this._dataConnect);
  Deserializer<ListStudentsData> dataDeserializer = (dynamic json) =>
      ListStudentsData.fromJson(jsonDecode(json));

  Future<QueryResult<ListStudentsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListStudentsData, void> ref() {
    return _dataConnect.query(
      "ListStudents",
      dataDeserializer,
      emptySerializer,
      null,
    );
  }
}

@immutable
class ListStudentsAlunos {
  final String id;
  final String nome;
  final int idade;
  final String responsavel;
  final String telefone;
  final String? email;
  final int presenca;
  final String status;
  final String? usuarioUid;
  final List<ListStudentsAlunosInscricoesOnAluno> inscricoes_on_aluno;
  final List<ListStudentsAlunosAlunoBolsasOnAluno> alunoBolsas_on_aluno;
  ListStudentsAlunos.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']),
      nome = nativeFromJson<String>(json['nome']),
      idade = nativeFromJson<int>(json['idade']),
      responsavel = nativeFromJson<String>(json['responsavel']),
      telefone = nativeFromJson<String>(json['telefone']),
      email = json['email'] == null
          ? null
          : nativeFromJson<String>(json['email']),
      presenca = nativeFromJson<int>(json['presenca']),
      status = nativeFromJson<String>(json['status']),
      usuarioUid = json['usuarioUid'] == null
          ? null
          : nativeFromJson<String>(json['usuarioUid']),
      inscricoes_on_aluno = (json['inscricoes_on_aluno'] as List<dynamic>)
          .map((e) => ListStudentsAlunosInscricoesOnAluno.fromJson(e))
          .toList(),
      alunoBolsas_on_aluno = (json['alunoBolsas_on_aluno'] as List<dynamic>)
          .map((e) => ListStudentsAlunosAlunoBolsasOnAluno.fromJson(e))
          .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListStudentsAlunos otherTyped = other as ListStudentsAlunos;
    return id == otherTyped.id &&
        nome == otherTyped.nome &&
        idade == otherTyped.idade &&
        responsavel == otherTyped.responsavel &&
        telefone == otherTyped.telefone &&
        email == otherTyped.email &&
        presenca == otherTyped.presenca &&
        status == otherTyped.status &&
        usuarioUid == otherTyped.usuarioUid &&
        inscricoes_on_aluno == otherTyped.inscricoes_on_aluno &&
        alunoBolsas_on_aluno == otherTyped.alunoBolsas_on_aluno;
  }

  @override
  int get hashCode => Object.hashAll([
    id.hashCode,
    nome.hashCode,
    idade.hashCode,
    responsavel.hashCode,
    telefone.hashCode,
    email.hashCode,
    presenca.hashCode,
    status.hashCode,
    usuarioUid.hashCode,
    inscricoes_on_aluno.hashCode,
    alunoBolsas_on_aluno.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    json['idade'] = nativeToJson<int>(idade);
    json['responsavel'] = nativeToJson<String>(responsavel);
    json['telefone'] = nativeToJson<String>(telefone);
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    json['presenca'] = nativeToJson<int>(presenca);
    json['status'] = nativeToJson<String>(status);
    if (usuarioUid != null) {
      json['usuarioUid'] = nativeToJson<String?>(usuarioUid);
    }
    json['inscricoes_on_aluno'] = inscricoes_on_aluno
        .map((e) => e.toJson())
        .toList();
    json['alunoBolsas_on_aluno'] = alunoBolsas_on_aluno
        .map((e) => e.toJson())
        .toList();
    return json;
  }

  const ListStudentsAlunos({
    required this.id,
    required this.nome,
    required this.idade,
    required this.responsavel,
    required this.telefone,
    this.email,
    required this.presenca,
    required this.status,
    this.usuarioUid,
    required this.inscricoes_on_aluno,
    required this.alunoBolsas_on_aluno,
  });
}

@immutable
class ListStudentsAlunosInscricoesOnAluno {
  final ListStudentsAlunosInscricoesOnAlunoAtividade atividade;
  ListStudentsAlunosInscricoesOnAluno.fromJson(dynamic json)
    : atividade = ListStudentsAlunosInscricoesOnAlunoAtividade.fromJson(
        json['atividade'],
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListStudentsAlunosInscricoesOnAluno otherTyped =
        other as ListStudentsAlunosInscricoesOnAluno;
    return atividade == otherTyped.atividade;
  }

  @override
  int get hashCode => atividade.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['atividade'] = atividade.toJson();
    return json;
  }

  const ListStudentsAlunosInscricoesOnAluno({required this.atividade});
}

@immutable
class ListStudentsAlunosInscricoesOnAlunoAtividade {
  final String id;
  final String nome;
  ListStudentsAlunosInscricoesOnAlunoAtividade.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']),
      nome = nativeFromJson<String>(json['nome']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListStudentsAlunosInscricoesOnAlunoAtividade otherTyped =
        other as ListStudentsAlunosInscricoesOnAlunoAtividade;
    return id == otherTyped.id && nome == otherTyped.nome;
  }

  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    return json;
  }

  const ListStudentsAlunosInscricoesOnAlunoAtividade({
    required this.id,
    required this.nome,
  });
}

@immutable
class ListStudentsAlunosAlunoBolsasOnAluno {
  final ListStudentsAlunosAlunoBolsasOnAlunoBolsa bolsa;
  ListStudentsAlunosAlunoBolsasOnAluno.fromJson(dynamic json)
    : bolsa = ListStudentsAlunosAlunoBolsasOnAlunoBolsa.fromJson(json['bolsa']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListStudentsAlunosAlunoBolsasOnAluno otherTyped =
        other as ListStudentsAlunosAlunoBolsasOnAluno;
    return bolsa == otherTyped.bolsa;
  }

  @override
  int get hashCode => bolsa.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['bolsa'] = bolsa.toJson();
    return json;
  }

  const ListStudentsAlunosAlunoBolsasOnAluno({required this.bolsa});
}

@immutable
class ListStudentsAlunosAlunoBolsasOnAlunoBolsa {
  final String id;
  final String nome;
  ListStudentsAlunosAlunoBolsasOnAlunoBolsa.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']),
      nome = nativeFromJson<String>(json['nome']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListStudentsAlunosAlunoBolsasOnAlunoBolsa otherTyped =
        other as ListStudentsAlunosAlunoBolsasOnAlunoBolsa;
    return id == otherTyped.id && nome == otherTyped.nome;
  }

  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    return json;
  }

  const ListStudentsAlunosAlunoBolsasOnAlunoBolsa({
    required this.id,
    required this.nome,
  });
}

@immutable
class ListStudentsData {
  final List<ListStudentsAlunos> alunos;
  ListStudentsData.fromJson(dynamic json)
    : alunos = (json['alunos'] as List<dynamic>)
          .map((e) => ListStudentsAlunos.fromJson(e))
          .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListStudentsData otherTyped = other as ListStudentsData;
    return alunos == otherTyped.alunos;
  }

  @override
  int get hashCode => alunos.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alunos'] = alunos.map((e) => e.toJson()).toList();
    return json;
  }

  const ListStudentsData({required this.alunos});
}
