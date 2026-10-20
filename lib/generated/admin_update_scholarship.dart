// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

part of 'example.dart';

class AdminUpdateScholarshipVariablesBuilder {
  String id;
  String nome;
  final Optional<String> _descricao = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );
  double valorMensal;
  bool ativa;

  final FirebaseDataConnect _dataConnect;
  AdminUpdateScholarshipVariablesBuilder descricao(String? t) {
    _descricao.value = t;
    return this;
  }

  AdminUpdateScholarshipVariablesBuilder(
    this._dataConnect, {
    required this.id,
    required this.nome,
    required this.valorMensal,
    required this.ativa,
  });
  Deserializer<AdminUpdateScholarshipData> dataDeserializer = (dynamic json) =>
      AdminUpdateScholarshipData.fromJson(jsonDecode(json));
  Serializer<AdminUpdateScholarshipVariables> varsSerializer =
      (AdminUpdateScholarshipVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<AdminUpdateScholarshipData, AdminUpdateScholarshipVariables>
  >
  execute() {
    return ref().execute();
  }

  MutationRef<AdminUpdateScholarshipData, AdminUpdateScholarshipVariables>
  ref() {
    AdminUpdateScholarshipVariables vars = AdminUpdateScholarshipVariables(
      id: id,
      nome: nome,
      descricao: _descricao,
      valorMensal: valorMensal,
      ativa: ativa,
    );
    return _dataConnect.mutation(
      "AdminUpdateScholarship",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class AdminUpdateScholarshipBolsaUpdate {
  final String id;
  AdminUpdateScholarshipBolsaUpdate.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminUpdateScholarshipBolsaUpdate otherTyped =
        other as AdminUpdateScholarshipBolsaUpdate;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const AdminUpdateScholarshipBolsaUpdate({required this.id});
}

@immutable
class AdminUpdateScholarshipData {
  final AdminUpdateScholarshipBolsaUpdate? bolsa_update;
  AdminUpdateScholarshipData.fromJson(dynamic json)
    : bolsa_update = json['bolsa_update'] == null
          ? null
          : AdminUpdateScholarshipBolsaUpdate.fromJson(json['bolsa_update']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminUpdateScholarshipData otherTyped =
        other as AdminUpdateScholarshipData;
    return bolsa_update == otherTyped.bolsa_update;
  }

  @override
  int get hashCode => bolsa_update.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (bolsa_update != null) {
      json['bolsa_update'] = bolsa_update!.toJson();
    }
    return json;
  }

  const AdminUpdateScholarshipData({this.bolsa_update});
}

@immutable
class AdminUpdateScholarshipVariables {
  final String id;
  final String nome;
  late final Optional<String> descricao;
  final double valorMensal;
  final bool ativa;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  AdminUpdateScholarshipVariables.fromJson(Map<String, dynamic> json)
    : id = nativeFromJson<String>(json['id']),
      nome = nativeFromJson<String>(json['nome']),
      valorMensal = nativeFromJson<double>(json['valorMensal']),
      ativa = nativeFromJson<bool>(json['ativa']) {
    descricao = Optional.optional(nativeFromJson, nativeToJson);
    descricao.value = json['descricao'] == null
        ? null
        : nativeFromJson<String>(json['descricao']);
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminUpdateScholarshipVariables otherTyped =
        other as AdminUpdateScholarshipVariables;
    return id == otherTyped.id &&
        nome == otherTyped.nome &&
        descricao == otherTyped.descricao &&
        valorMensal == otherTyped.valorMensal &&
        ativa == otherTyped.ativa;
  }

  @override
  int get hashCode => Object.hashAll([
    id.hashCode,
    nome.hashCode,
    descricao.hashCode,
    valorMensal.hashCode,
    ativa.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    if (descricao.state == OptionalState.set) {
      json['descricao'] = descricao.toJson();
    }
    json['valorMensal'] = nativeToJson<double>(valorMensal);
    json['ativa'] = nativeToJson<bool>(ativa);
    return json;
  }

  AdminUpdateScholarshipVariables({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.valorMensal,
    required this.ativa,
  });
}
