// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

part of 'example.dart';

class AdminCreateActivityVariablesBuilder {
  String nome;
  String professor;
  final Optional<String> _descricao = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );
  final Optional<String> _horario = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );
  final Optional<String> _dias = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );
  int vagas;
  final Optional<String> _categoria = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );

  final FirebaseDataConnect _dataConnect;
  AdminCreateActivityVariablesBuilder descricao(String? t) {
    _descricao.value = t;
    return this;
  }

  AdminCreateActivityVariablesBuilder horario(String? t) {
    _horario.value = t;
    return this;
  }

  AdminCreateActivityVariablesBuilder dias(String? t) {
    _dias.value = t;
    return this;
  }

  AdminCreateActivityVariablesBuilder categoria(String? t) {
    _categoria.value = t;
    return this;
  }

  AdminCreateActivityVariablesBuilder(
    this._dataConnect, {
    required this.nome,
    required this.professor,
    required this.vagas,
  });
  Deserializer<AdminCreateActivityData> dataDeserializer = (dynamic json) =>
      AdminCreateActivityData.fromJson(jsonDecode(json));
  Serializer<AdminCreateActivityVariables> varsSerializer =
      (AdminCreateActivityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AdminCreateActivityData, AdminCreateActivityVariables>>
  execute() {
    return ref().execute();
  }

  MutationRef<AdminCreateActivityData, AdminCreateActivityVariables> ref() {
    AdminCreateActivityVariables vars = AdminCreateActivityVariables(
      nome: nome,
      professor: professor,
      descricao: _descricao,
      horario: _horario,
      dias: _dias,
      vagas: vagas,
      categoria: _categoria,
    );
    return _dataConnect.mutation(
      "AdminCreateActivity",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class AdminCreateActivityAtividadeInsert {
  final String id;
  AdminCreateActivityAtividadeInsert.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateActivityAtividadeInsert otherTyped =
        other as AdminCreateActivityAtividadeInsert;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const AdminCreateActivityAtividadeInsert({required this.id});
}

@immutable
class AdminCreateActivityData {
  final AdminCreateActivityAtividadeInsert atividade_insert;
  AdminCreateActivityData.fromJson(dynamic json)
    : atividade_insert = AdminCreateActivityAtividadeInsert.fromJson(
        json['atividade_insert'],
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateActivityData otherTyped = other as AdminCreateActivityData;
    return atividade_insert == otherTyped.atividade_insert;
  }

  @override
  int get hashCode => atividade_insert.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['atividade_insert'] = atividade_insert.toJson();
    return json;
  }

  const AdminCreateActivityData({required this.atividade_insert});
}

@immutable
class AdminCreateActivityVariables {
  final String nome;
  final String professor;
  late final Optional<String> descricao;
  late final Optional<String> horario;
  late final Optional<String> dias;
  final int vagas;
  late final Optional<String> categoria;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  AdminCreateActivityVariables.fromJson(Map<String, dynamic> json)
    : nome = nativeFromJson<String>(json['nome']),
      professor = nativeFromJson<String>(json['professor']),
      vagas = nativeFromJson<int>(json['vagas']) {
    descricao = Optional.optional(nativeFromJson, nativeToJson);
    descricao.value = json['descricao'] == null
        ? null
        : nativeFromJson<String>(json['descricao']);

    horario = Optional.optional(nativeFromJson, nativeToJson);
    horario.value = json['horario'] == null
        ? null
        : nativeFromJson<String>(json['horario']);

    dias = Optional.optional(nativeFromJson, nativeToJson);
    dias.value = json['dias'] == null
        ? null
        : nativeFromJson<String>(json['dias']);

    categoria = Optional.optional(nativeFromJson, nativeToJson);
    categoria.value = json['categoria'] == null
        ? null
        : nativeFromJson<String>(json['categoria']);
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateActivityVariables otherTyped =
        other as AdminCreateActivityVariables;
    return nome == otherTyped.nome &&
        professor == otherTyped.professor &&
        descricao == otherTyped.descricao &&
        horario == otherTyped.horario &&
        dias == otherTyped.dias &&
        vagas == otherTyped.vagas &&
        categoria == otherTyped.categoria;
  }

  @override
  int get hashCode => Object.hashAll([
    nome.hashCode,
    professor.hashCode,
    descricao.hashCode,
    horario.hashCode,
    dias.hashCode,
    vagas.hashCode,
    categoria.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    json['professor'] = nativeToJson<String>(professor);
    if (descricao.state == OptionalState.set) {
      json['descricao'] = descricao.toJson();
    }
    if (horario.state == OptionalState.set) {
      json['horario'] = horario.toJson();
    }
    if (dias.state == OptionalState.set) {
      json['dias'] = dias.toJson();
    }
    json['vagas'] = nativeToJson<int>(vagas);
    if (categoria.state == OptionalState.set) {
      json['categoria'] = categoria.toJson();
    }
    return json;
  }

  AdminCreateActivityVariables({
    required this.nome,
    required this.professor,
    required this.descricao,
    required this.horario,
    required this.dias,
    required this.vagas,
    required this.categoria,
  });
}
