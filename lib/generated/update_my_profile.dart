part of 'example.dart';

class UpdateMyProfileVariablesBuilder {
  String nome;
  final Optional<String> _telefone = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );

  final FirebaseDataConnect _dataConnect;
  UpdateMyProfileVariablesBuilder telefone(String? t) {
    _telefone.value = t;
    return this;
  }

  UpdateMyProfileVariablesBuilder(this._dataConnect, {required this.nome});
  Deserializer<UpdateMyProfileData> dataDeserializer = (dynamic json) =>
      UpdateMyProfileData.fromJson(jsonDecode(json));
  Serializer<UpdateMyProfileVariables> varsSerializer =
      (UpdateMyProfileVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateMyProfileData, UpdateMyProfileVariables>>
  execute() {
    return ref().execute();
  }

  MutationRef<UpdateMyProfileData, UpdateMyProfileVariables> ref() {
    UpdateMyProfileVariables vars = UpdateMyProfileVariables(
      nome: nome,
      telefone: _telefone,
    );
    return _dataConnect.mutation(
      "UpdateMyProfile",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class UpdateMyProfileUsuarioUpdate {
  final String uid;
  UpdateMyProfileUsuarioUpdate.fromJson(dynamic json)
    : uid = nativeFromJson<String>(json['uid']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMyProfileUsuarioUpdate otherTyped =
        other as UpdateMyProfileUsuarioUpdate;
    return uid == otherTyped.uid;
  }

  @override
  int get hashCode => uid.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['uid'] = nativeToJson<String>(uid);
    return json;
  }

  const UpdateMyProfileUsuarioUpdate({required this.uid});
}

@immutable
class UpdateMyProfileData {
  final UpdateMyProfileUsuarioUpdate? usuario_update;
  UpdateMyProfileData.fromJson(dynamic json)
    : usuario_update = json['usuario_update'] == null
          ? null
          : UpdateMyProfileUsuarioUpdate.fromJson(json['usuario_update']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMyProfileData otherTyped = other as UpdateMyProfileData;
    return usuario_update == otherTyped.usuario_update;
  }

  @override
  int get hashCode => usuario_update.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (usuario_update != null) {
      json['usuario_update'] = usuario_update!.toJson();
    }
    return json;
  }

  const UpdateMyProfileData({this.usuario_update});
}

@immutable
class UpdateMyProfileVariables {
  final String nome;
  late final Optional<String> telefone;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  UpdateMyProfileVariables.fromJson(Map<String, dynamic> json)
    : nome = nativeFromJson<String>(json['nome']) {
    telefone = Optional.optional(nativeFromJson, nativeToJson);
    telefone.value = json['telefone'] == null
        ? null
        : nativeFromJson<String>(json['telefone']);
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateMyProfileVariables otherTyped =
        other as UpdateMyProfileVariables;
    return nome == otherTyped.nome && telefone == otherTyped.telefone;
  }

  @override
  int get hashCode => Object.hashAll([nome.hashCode, telefone.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    if (telefone.state == OptionalState.set) {
      json['telefone'] = telefone.toJson();
    }
    return json;
  }

  UpdateMyProfileVariables({required this.nome, required this.telefone});
}
