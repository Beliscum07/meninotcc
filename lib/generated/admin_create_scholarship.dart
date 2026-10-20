part of 'example.dart';

class AdminCreateScholarshipVariablesBuilder {
  String nome;
  final Optional<String> _descricao = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );
  double valorMensal;

  final FirebaseDataConnect _dataConnect;
  AdminCreateScholarshipVariablesBuilder descricao(String? t) {
    _descricao.value = t;
    return this;
  }

  AdminCreateScholarshipVariablesBuilder(
    this._dataConnect, {
    required this.nome,
    required this.valorMensal,
  });
  Deserializer<AdminCreateScholarshipData> dataDeserializer = (dynamic json) =>
      AdminCreateScholarshipData.fromJson(jsonDecode(json));
  Serializer<AdminCreateScholarshipVariables> varsSerializer =
      (AdminCreateScholarshipVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<AdminCreateScholarshipData, AdminCreateScholarshipVariables>
  >
  execute() {
    return ref().execute();
  }

  MutationRef<AdminCreateScholarshipData, AdminCreateScholarshipVariables>
  ref() {
    AdminCreateScholarshipVariables vars = AdminCreateScholarshipVariables(
      nome: nome,
      descricao: _descricao,
      valorMensal: valorMensal,
    );
    return _dataConnect.mutation(
      "AdminCreateScholarship",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class AdminCreateScholarshipBolsaInsert {
  final String id;
  AdminCreateScholarshipBolsaInsert.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateScholarshipBolsaInsert otherTyped =
        other as AdminCreateScholarshipBolsaInsert;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const AdminCreateScholarshipBolsaInsert({required this.id});
}

@immutable
class AdminCreateScholarshipData {
  final AdminCreateScholarshipBolsaInsert bolsa_insert;
  AdminCreateScholarshipData.fromJson(dynamic json)
    : bolsa_insert = AdminCreateScholarshipBolsaInsert.fromJson(
        json['bolsa_insert'],
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateScholarshipData otherTyped =
        other as AdminCreateScholarshipData;
    return bolsa_insert == otherTyped.bolsa_insert;
  }

  @override
  int get hashCode => bolsa_insert.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['bolsa_insert'] = bolsa_insert.toJson();
    return json;
  }

  const AdminCreateScholarshipData({required this.bolsa_insert});
}

@immutable
class AdminCreateScholarshipVariables {
  final String nome;
  late final Optional<String> descricao;
  final double valorMensal;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  AdminCreateScholarshipVariables.fromJson(Map<String, dynamic> json)
    : nome = nativeFromJson<String>(json['nome']),
      valorMensal = nativeFromJson<double>(json['valorMensal']) {
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

    final AdminCreateScholarshipVariables otherTyped =
        other as AdminCreateScholarshipVariables;
    return nome == otherTyped.nome &&
        descricao == otherTyped.descricao &&
        valorMensal == otherTyped.valorMensal;
  }

  @override
  int get hashCode =>
      Object.hashAll([nome.hashCode, descricao.hashCode, valorMensal.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    if (descricao.state == OptionalState.set) {
      json['descricao'] = descricao.toJson();
    }
    json['valorMensal'] = nativeToJson<double>(valorMensal);
    return json;
  }

  AdminCreateScholarshipVariables({
    required this.nome,
    required this.descricao,
    required this.valorMensal,
  });
}
