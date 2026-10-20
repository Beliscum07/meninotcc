part of 'example.dart';

class RegisterMyDonationVariablesBuilder {
  double valor;
  final Optional<String> _metodo = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );

  final FirebaseDataConnect _dataConnect;
  RegisterMyDonationVariablesBuilder metodo(String? t) {
    _metodo.value = t;
    return this;
  }

  RegisterMyDonationVariablesBuilder(this._dataConnect, {required this.valor});
  Deserializer<RegisterMyDonationData> dataDeserializer = (dynamic json) =>
      RegisterMyDonationData.fromJson(jsonDecode(json));
  Serializer<RegisterMyDonationVariables> varsSerializer =
      (RegisterMyDonationVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<RegisterMyDonationData, RegisterMyDonationVariables>>
  execute() {
    return ref().execute();
  }

  MutationRef<RegisterMyDonationData, RegisterMyDonationVariables> ref() {
    RegisterMyDonationVariables vars = RegisterMyDonationVariables(
      valor: valor,
      metodo: _metodo,
    );
    return _dataConnect.mutation(
      "RegisterMyDonation",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class RegisterMyDonationDoacaoInsert {
  final String id;
  RegisterMyDonationDoacaoInsert.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterMyDonationDoacaoInsert otherTyped =
        other as RegisterMyDonationDoacaoInsert;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const RegisterMyDonationDoacaoInsert({required this.id});
}

@immutable
class RegisterMyDonationData {
  final RegisterMyDonationDoacaoInsert doacao_insert;
  RegisterMyDonationData.fromJson(dynamic json)
    : doacao_insert = RegisterMyDonationDoacaoInsert.fromJson(
        json['doacao_insert'],
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterMyDonationData otherTyped = other as RegisterMyDonationData;
    return doacao_insert == otherTyped.doacao_insert;
  }

  @override
  int get hashCode => doacao_insert.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['doacao_insert'] = doacao_insert.toJson();
    return json;
  }

  const RegisterMyDonationData({required this.doacao_insert});
}

@immutable
class RegisterMyDonationVariables {
  final double valor;
  late final Optional<String> metodo;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  RegisterMyDonationVariables.fromJson(Map<String, dynamic> json)
    : valor = nativeFromJson<double>(json['valor']) {
    metodo = Optional.optional(nativeFromJson, nativeToJson);
    metodo.value = json['metodo'] == null
        ? null
        : nativeFromJson<String>(json['metodo']);
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterMyDonationVariables otherTyped =
        other as RegisterMyDonationVariables;
    return valor == otherTyped.valor && metodo == otherTyped.metodo;
  }

  @override
  int get hashCode => Object.hashAll([valor.hashCode, metodo.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['valor'] = nativeToJson<double>(valor);
    if (metodo.state == OptionalState.set) {
      json['metodo'] = metodo.toJson();
    }
    return json;
  }

  RegisterMyDonationVariables({
    required this.valor,
    required this.metodo,
  });
}
