part of 'example.dart';

class ListMyActivitiesVariablesBuilder {
  final FirebaseDataConnect _dataConnect;
  ListMyActivitiesVariablesBuilder(this._dataConnect);
  Deserializer<ListMyActivitiesData> dataDeserializer = (dynamic json) =>
      ListMyActivitiesData.fromJson(jsonDecode(json));

  Future<QueryResult<ListMyActivitiesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMyActivitiesData, void> ref() {
    return _dataConnect.query(
      "ListMyActivities",
      dataDeserializer,
      emptySerializer,
      null,
    );
  }
}

@immutable
class ListMyActivitiesInscricoes {
  final ListMyActivitiesInscricoesAtividade atividade;
  ListMyActivitiesInscricoes.fromJson(dynamic json)
    : atividade = ListMyActivitiesInscricoesAtividade.fromJson(
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

    final ListMyActivitiesInscricoes otherTyped =
        other as ListMyActivitiesInscricoes;
    return atividade == otherTyped.atividade;
  }

  @override
  int get hashCode => atividade.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['atividade'] = atividade.toJson();
    return json;
  }

  const ListMyActivitiesInscricoes({required this.atividade});
}

@immutable
class ListMyActivitiesInscricoesAtividade {
  final String id;
  final String nome;
  final String professor;
  final String? descricao;
  final String? horario;
  final String? dias;
  final int vagas;
  ListMyActivitiesInscricoesAtividade.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']),
      nome = nativeFromJson<String>(json['nome']),
      professor = nativeFromJson<String>(json['professor']),
      descricao = json['descricao'] == null
          ? null
          : nativeFromJson<String>(json['descricao']),
      horario = json['horario'] == null
          ? null
          : nativeFromJson<String>(json['horario']),
      dias = json['dias'] == null ? null : nativeFromJson<String>(json['dias']),
      vagas = nativeFromJson<int>(json['vagas']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyActivitiesInscricoesAtividade otherTyped =
        other as ListMyActivitiesInscricoesAtividade;
    return id == otherTyped.id &&
        nome == otherTyped.nome &&
        professor == otherTyped.professor &&
        descricao == otherTyped.descricao &&
        horario == otherTyped.horario &&
        dias == otherTyped.dias &&
        vagas == otherTyped.vagas;
  }

  @override
  int get hashCode => Object.hashAll([
    id.hashCode,
    nome.hashCode,
    professor.hashCode,
    descricao.hashCode,
    horario.hashCode,
    dias.hashCode,
    vagas.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    json['professor'] = nativeToJson<String>(professor);
    if (descricao != null) {
      json['descricao'] = nativeToJson<String?>(descricao);
    }
    if (horario != null) {
      json['horario'] = nativeToJson<String?>(horario);
    }
    if (dias != null) {
      json['dias'] = nativeToJson<String?>(dias);
    }
    json['vagas'] = nativeToJson<int>(vagas);
    return json;
  }

  const ListMyActivitiesInscricoesAtividade({
    required this.id,
    required this.nome,
    required this.professor,
    this.descricao,
    this.horario,
    this.dias,
    required this.vagas,
  });
}

@immutable
class ListMyActivitiesData {
  final List<ListMyActivitiesInscricoes> inscricoes;
  ListMyActivitiesData.fromJson(dynamic json)
    : inscricoes = (json['inscricoes'] as List<dynamic>)
          .map((e) => ListMyActivitiesInscricoes.fromJson(e))
          .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyActivitiesData otherTyped = other as ListMyActivitiesData;
    return inscricoes == otherTyped.inscricoes;
  }

  @override
  int get hashCode => inscricoes.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['inscricoes'] = inscricoes.map((e) => e.toJson()).toList();
    return json;
  }

  const ListMyActivitiesData({required this.inscricoes});
}
