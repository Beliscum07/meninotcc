// ignore_for_file: non_constant_identifier_names
// These names preserve generated GraphQL field aliases.
part of 'example.dart';

class RegisterDonorProfileVariablesBuilder {
  String nome;
  String telefone;

  final FirebaseDataConnect _dataConnect;
  RegisterDonorProfileVariablesBuilder(
    this._dataConnect, {
    required this.nome,
    required this.telefone,
  });
  Deserializer<RegisterDonorProfileData> dataDeserializer = (dynamic json) =>
      RegisterDonorProfileData.fromJson(jsonDecode(json));
  Serializer<RegisterDonorProfileVariables> varsSerializer =
      (RegisterDonorProfileVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<RegisterDonorProfileData, RegisterDonorProfileVariables>
  >
  execute() {
    return ref().execute();
  }

  MutationRef<RegisterDonorProfileData, RegisterDonorProfileVariables> ref() {
    RegisterDonorProfileVariables vars = RegisterDonorProfileVariables(
      nome: nome,
      telefone: telefone,
    );
    return _dataConnect.mutation(
      "RegisterDonorProfile",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class RegisterDonorProfileUsuarioInsert {
  final String uid;
  RegisterDonorProfileUsuarioInsert.fromJson(dynamic json)
    : uid = nativeFromJson<String>(json['uid']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterDonorProfileUsuarioInsert otherTyped =
        other as RegisterDonorProfileUsuarioInsert;
    return uid == otherTyped.uid;
  }

  @override
  int get hashCode => uid.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['uid'] = nativeToJson<String>(uid);
    return json;
  }

  const RegisterDonorProfileUsuarioInsert({required this.uid});
}

@immutable
class RegisterDonorProfileDoadorInsert {
  final String id;
  RegisterDonorProfileDoadorInsert.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterDonorProfileDoadorInsert otherTyped =
        other as RegisterDonorProfileDoadorInsert;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const RegisterDonorProfileDoadorInsert({required this.id});
}

@immutable
class RegisterDonorProfileData {
  final RegisterDonorProfileUsuarioInsert usuario_insert;
  final RegisterDonorProfileDoadorInsert doador_insert;
  RegisterDonorProfileData.fromJson(dynamic json)
    : usuario_insert = RegisterDonorProfileUsuarioInsert.fromJson(
        json['usuario_insert'],
      ),
      doador_insert = RegisterDonorProfileDoadorInsert.fromJson(
        json['doador_insert'],
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterDonorProfileData otherTyped =
        other as RegisterDonorProfileData;
    return usuario_insert == otherTyped.usuario_insert &&
        doador_insert == otherTyped.doador_insert;
  }

  @override
  int get hashCode =>
      Object.hashAll([usuario_insert.hashCode, doador_insert.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['usuario_insert'] = usuario_insert.toJson();
    json['doador_insert'] = doador_insert.toJson();
    return json;
  }

  const RegisterDonorProfileData({
    required this.usuario_insert,
    required this.doador_insert,
  });
}

@immutable
class RegisterDonorProfileVariables {
  final String nome;
  final String telefone;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  RegisterDonorProfileVariables.fromJson(Map<String, dynamic> json)
    : nome = nativeFromJson<String>(json['nome']),
      telefone = nativeFromJson<String>(json['telefone']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final RegisterDonorProfileVariables otherTyped =
        other as RegisterDonorProfileVariables;
    return nome == otherTyped.nome && telefone == otherTyped.telefone;
  }

  @override
  int get hashCode => Object.hashAll([nome.hashCode, telefone.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    json['telefone'] = nativeToJson<String>(telefone);
    return json;
  }

  const RegisterDonorProfileVariables({
    required this.nome,
    required this.telefone,
  });
}
