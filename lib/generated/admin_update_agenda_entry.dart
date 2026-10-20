// ignore_for_file: non_constant_identifier_names
// These names preserve generated GraphQL field aliases.
part of 'example.dart';

class AdminUpdateAgendaEntryVariablesBuilder {
  String id;
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
  String status;

  final FirebaseDataConnect _dataConnect;
  AdminUpdateAgendaEntryVariablesBuilder descricao(String? t) {
    _descricao.value = t;
    return this;
  }

  AdminUpdateAgendaEntryVariablesBuilder fim(Timestamp? t) {
    _fim.value = t;
    return this;
  }

  AdminUpdateAgendaEntryVariablesBuilder local(String? t) {
    _local.value = t;
    return this;
  }

  AdminUpdateAgendaEntryVariablesBuilder atividadeId(String? t) {
    _atividadeId.value = t;
    return this;
  }

  AdminUpdateAgendaEntryVariablesBuilder(
    this._dataConnect, {
    required this.id,
    required this.titulo,
    required this.inicio,
    required this.status,
  });
  Deserializer<AdminUpdateAgendaEntryData> dataDeserializer = (dynamic json) =>
      AdminUpdateAgendaEntryData.fromJson(jsonDecode(json));
  Serializer<AdminUpdateAgendaEntryVariables> varsSerializer =
      (AdminUpdateAgendaEntryVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<AdminUpdateAgendaEntryData, AdminUpdateAgendaEntryVariables>
  >
  execute() {
    return ref().execute();
  }

  MutationRef<AdminUpdateAgendaEntryData, AdminUpdateAgendaEntryVariables>
  ref() {
    AdminUpdateAgendaEntryVariables vars = AdminUpdateAgendaEntryVariables(
      id: id,
      titulo: titulo,
      descricao: _descricao,
      inicio: inicio,
      fim: _fim,
      local: _local,
      atividadeId: _atividadeId,
      status: status,
    );
    return _dataConnect.mutation(
      "AdminUpdateAgendaEntry",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class AdminUpdateAgendaEntryAgendaUpdate {
  final String id;
  AdminUpdateAgendaEntryAgendaUpdate.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminUpdateAgendaEntryAgendaUpdate otherTyped =
        other as AdminUpdateAgendaEntryAgendaUpdate;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const AdminUpdateAgendaEntryAgendaUpdate({required this.id});
}

@immutable
class AdminUpdateAgendaEntryData {
  final AdminUpdateAgendaEntryAgendaUpdate? agenda_update;
  AdminUpdateAgendaEntryData.fromJson(dynamic json)
    : agenda_update = json['agenda_update'] == null
          ? null
          : AdminUpdateAgendaEntryAgendaUpdate.fromJson(json['agenda_update']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminUpdateAgendaEntryData otherTyped =
        other as AdminUpdateAgendaEntryData;
    return agenda_update == otherTyped.agenda_update;
  }

  @override
  int get hashCode => agenda_update.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (agenda_update != null) {
      json['agenda_update'] = agenda_update!.toJson();
    }
    return json;
  }

  const AdminUpdateAgendaEntryData({this.agenda_update});
}

@immutable
class AdminUpdateAgendaEntryVariables {
  final String id;
  final String titulo;
  late final Optional<String> descricao;
  final Timestamp inicio;
  late final Optional<Timestamp> fim;
  late final Optional<String> local;
  late final Optional<String> atividadeId;
  final String status;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  AdminUpdateAgendaEntryVariables.fromJson(Map<String, dynamic> json)
    : id = nativeFromJson<String>(json['id']),
      titulo = nativeFromJson<String>(json['titulo']),
      inicio = Timestamp.fromJson(json['inicio']),
      status = nativeFromJson<String>(json['status']) {
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

    final AdminUpdateAgendaEntryVariables otherTyped =
        other as AdminUpdateAgendaEntryVariables;
    return id == otherTyped.id &&
        titulo == otherTyped.titulo &&
        descricao == otherTyped.descricao &&
        inicio == otherTyped.inicio &&
        fim == otherTyped.fim &&
        local == otherTyped.local &&
        atividadeId == otherTyped.atividadeId &&
        status == otherTyped.status;
  }

  @override
  int get hashCode => Object.hashAll([
    id.hashCode,
    titulo.hashCode,
    descricao.hashCode,
    inicio.hashCode,
    fim.hashCode,
    local.hashCode,
    atividadeId.hashCode,
    status.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
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
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  // Optional wrappers are initialized by fromJson, so this constructor cannot be const.
  // ignore: prefer_const_constructors_in_immutables
  AdminUpdateAgendaEntryVariables({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.inicio,
    required this.fim,
    required this.local,
    required this.atividadeId,
    required this.status,
  });
}
