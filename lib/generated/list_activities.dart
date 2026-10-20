part of 'example.dart';

class ListActivitiesVariablesBuilder {
  final FirebaseDataConnect _dataConnect;
  ListActivitiesVariablesBuilder(this._dataConnect);
  Deserializer<ListActivitiesData> dataDeserializer = (dynamic json) =>
      ListActivitiesData.fromJson(jsonDecode(json));

  Future<QueryResult<ListActivitiesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListActivitiesData, void> ref() {
    return _dataConnect.query(
      "ListActivities",
      dataDeserializer,
      emptySerializer,
      null,
    );
  }
}

@immutable
class ListActivitiesAtividades {
  final String id;
  final String nome;
  final String professor;
  final String? descricao;
  final String? horario;
  final String? dias;
  final int vagas;
  final String? categoria;
  final String status;
  final List<ListActivitiesAtividadesInscricoesOnAtividade>
  inscricoes_on_atividade;
  ListActivitiesAtividades.fromJson(dynamic json)
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
      vagas = nativeFromJson<int>(json['vagas']),
      categoria = json['categoria'] == null
          ? null
          : nativeFromJson<String>(json['categoria']),
      status = nativeFromJson<String>(json['status']),
      inscricoes_on_atividade =
          (json['inscricoes_on_atividade'] as List<dynamic>)
              .map(
                (e) =>
                    ListActivitiesAtividadesInscricoesOnAtividade.fromJson(e),
              )
              .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListActivitiesAtividades otherTyped =
        other as ListActivitiesAtividades;
    return id == otherTyped.id &&
        nome == otherTyped.nome &&
        professor == otherTyped.professor &&
        descricao == otherTyped.descricao &&
        horario == otherTyped.horario &&
        dias == otherTyped.dias &&
        vagas == otherTyped.vagas &&
        categoria == otherTyped.categoria &&
        status == otherTyped.status &&
        inscricoes_on_atividade == otherTyped.inscricoes_on_atividade;
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
    categoria.hashCode,
    status.hashCode,
    inscricoes_on_atividade.hashCode,
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
    if (categoria != null) {
      json['categoria'] = nativeToJson<String?>(categoria);
    }
    json['status'] = nativeToJson<String>(status);
    json['inscricoes_on_atividade'] = inscricoes_on_atividade
        .map((e) => e.toJson())
        .toList();
    return json;
  }

  const ListActivitiesAtividades({
    required this.id,
    required this.nome,
    required this.professor,
    this.descricao,
    this.horario,
    this.dias,
    required this.vagas,
    this.categoria,
    required this.status,
    required this.inscricoes_on_atividade,
  });
}

@immutable
class ListActivitiesAtividadesInscricoesOnAtividade {
  final String status;
  ListActivitiesAtividadesInscricoesOnAtividade.fromJson(dynamic json)
    : status = nativeFromJson<String>(json['status']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListActivitiesAtividadesInscricoesOnAtividade otherTyped =
        other as ListActivitiesAtividadesInscricoesOnAtividade;
    return status == otherTyped.status;
  }

  @override
  int get hashCode => status.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  const ListActivitiesAtividadesInscricoesOnAtividade({required this.status});
}

@immutable
class ListActivitiesData {
  final List<ListActivitiesAtividades> atividades;
  ListActivitiesData.fromJson(dynamic json)
    : atividades = (json['atividades'] as List<dynamic>)
          .map((e) => ListActivitiesAtividades.fromJson(e))
          .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListActivitiesData otherTyped = other as ListActivitiesData;
    return atividades == otherTyped.atividades;
  }

  @override
  int get hashCode => atividades.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['atividades'] = atividades.map((e) => e.toJson()).toList();
    return json;
  }

  const ListActivitiesData({required this.atividades});
}
