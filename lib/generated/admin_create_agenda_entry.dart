// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

part of 'example.dart';

class AdminCreateAgendaEntryVariablesBuilder {
  String titulo;
  final Optional<String> _descricao = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );
  Timestamp inicio;
  final Optional<Timestamp> _fim = Optional.optional(
    (json) => json['fim'] = Timestamp.fromJson(json['fim']),
    defaultSerializer,
  );
  final Optional<String> _local = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );
  final Optional<String> _atividadeId = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );

  final FirebaseDataConnect _dataConnect;
  AdminCreateAgendaEntryVariablesBuilder descricao(String? t) {
    _descricao.value = t;
    return this;
  }

  AdminCreateAgendaEntryVariablesBuilder fim(Timestamp? t) {
    _fim.value = t;
    return this;
  }

  AdminCreateAgendaEntryVariablesBuilder local(String? t) {
    _local.value = t;
    return this;
  }

  AdminCreateAgendaEntryVariablesBuilder atividadeId(String? t) {
    _atividadeId.value = t;
    return this;
  }

  AdminCreateAgendaEntryVariablesBuilder(
    this._dataConnect, {
    required this.titulo,
    required this.inicio,
  });
  Deserializer<AdminCreateAgendaEntryData> dataDeserializer = (dynamic json) =>
      AdminCreateAgendaEntryData.fromJson(jsonDecode(json));
  Serializer<AdminCreateAgendaEntryVariables> varsSerializer =
      (AdminCreateAgendaEntryVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<AdminCreateAgendaEntryData, AdminCreateAgendaEntryVariables>
  >
  execute() {
    return ref().execute();
  }

  MutationRef<AdminCreateAgendaEntryData, AdminCreateAgendaEntryVariables>
  ref() {
    AdminCreateAgendaEntryVariables vars = AdminCreateAgendaEntryVariables(
      titulo: titulo,
      descricao: _descricao,
      inicio: inicio,
      fim: _fim,
      local: _local,
      atividadeId: _atividadeId,
    );
    return _dataConnect.mutation(
      "AdminCreateAgendaEntry",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class AdminCreateAgendaEntryAgendaInsert {
  final String id;
  AdminCreateAgendaEntryAgendaInsert.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateAgendaEntryAgendaInsert otherTyped =
        other as AdminCreateAgendaEntryAgendaInsert;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const AdminCreateAgendaEntryAgendaInsert({required this.id});
}

@immutable
class AdminCreateAgendaEntryData {
  final AdminCreateAgendaEntryAgendaInsert agenda_insert;
  AdminCreateAgendaEntryData.fromJson(dynamic json)
    : agenda_insert = AdminCreateAgendaEntryAgendaInsert.fromJson(
        json['agenda_insert'],
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateAgendaEntryData otherTyped =
        other as AdminCreateAgendaEntryData;
    return agenda_insert == otherTyped.agenda_insert;
  }

  @override
  int get hashCode => agenda_insert.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['agenda_insert'] = agenda_insert.toJson();
    return json;
  }

  const AdminCreateAgendaEntryData({required this.agenda_insert});
}

@immutable
class AdminCreateAgendaEntryVariables {
  final String titulo;
  late final Optional<String> descricao;
  final Timestamp inicio;
  late final Optional<Timestamp> fim;
  late final Optional<String> local;
  late final Optional<String> atividadeId;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  AdminCreateAgendaEntryVariables.fromJson(Map<String, dynamic> json)
    : titulo = nativeFromJson<String>(json['titulo']),
      inicio = Timestamp.fromJson(json['inicio']) {
    descricao = Optional.optional(nativeFromJson, nativeToJson);
    descricao.value = json['descricao'] == null
        ? null
        : nativeFromJson<String>(json['descricao']);

    fim = Optional.optional(
      (json) => json['fim'] = Timestamp.fromJson(json['fim']),
      defaultSerializer,
    );
    fim.value = json['fim'] == null ? null : Timestamp.fromJson(json['fim']);

    local = Optional.optional(nativeFromJson, nativeToJson);
    local.value = json['local'] == null
        ? null
        : nativeFromJson<String>(json['local']);

    atividadeId = Optional.optional(nativeFromJson, nativeToJson);
    atividadeId.value = json['atividadeId'] == null
        ? null
        : nativeFromJson<String>(json['atividadeId']);
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateAgendaEntryVariables otherTyped =
        other as AdminCreateAgendaEntryVariables;
    return titulo == otherTyped.titulo &&
        descricao == otherTyped.descricao &&
        inicio == otherTyped.inicio &&
        fim == otherTyped.fim &&
        local == otherTyped.local &&
        atividadeId == otherTyped.atividadeId;
  }

  @override
  int get hashCode => Object.hashAll([
    titulo.hashCode,
    descricao.hashCode,
    inicio.hashCode,
    fim.hashCode,
    local.hashCode,
    atividadeId.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['titulo'] = nativeToJson<String>(titulo);
    if (descricao.state == OptionalState.set) {
      json['descricao'] = descricao.toJson();
    }
    json['inicio'] = inicio.toJson();
    if (fim.state == OptionalState.set) {
      json['fim'] = fim.toJson();
    }
    if (local.state == OptionalState.set) {
      json['local'] = local.toJson();
    }
    if (atividadeId.state == OptionalState.set) {
      json['atividadeId'] = atividadeId.toJson();
    }
    return json;
  }

  AdminCreateAgendaEntryVariables({
    required this.titulo,
    required this.descricao,
    required this.inicio,
    required this.fim,
    required this.local,
    required this.atividadeId,
  });
}
