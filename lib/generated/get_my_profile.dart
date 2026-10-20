part of 'example.dart';

class GetMyProfileVariablesBuilder {
  final FirebaseDataConnect _dataConnect;
  GetMyProfileVariablesBuilder(this._dataConnect);
  Deserializer<GetMyProfileData> dataDeserializer = (dynamic json) =>
      GetMyProfileData.fromJson(jsonDecode(json));

  Future<QueryResult<GetMyProfileData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetMyProfileData, void> ref() {
    return _dataConnect.query(
      "GetMyProfile",
      dataDeserializer,
      emptySerializer,
      null,
    );
  }
}

@immutable
class GetMyProfileUsuario {
  final String uid;
  final String nome;
  final String email;
  final String? telefone;
  final String papel;
  final String status;
  GetMyProfileUsuario.fromJson(dynamic json)
    : uid = nativeFromJson<String>(json['uid']),
      nome = nativeFromJson<String>(json['nome']),
      email = nativeFromJson<String>(json['email']),
      telefone = json['telefone'] == null
          ? null
          : nativeFromJson<String>(json['telefone']),
      papel = nativeFromJson<String>(json['papel']),
      status = nativeFromJson<String>(json['status']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyProfileUsuario otherTyped = other as GetMyProfileUsuario;
    return uid == otherTyped.uid &&
        nome == otherTyped.nome &&
        email == otherTyped.email &&
        telefone == otherTyped.telefone &&
        papel == otherTyped.papel &&
        status == otherTyped.status;
  }

  @override
  int get hashCode => Object.hashAll([
    uid.hashCode,
    nome.hashCode,
    email.hashCode,
    telefone.hashCode,
    papel.hashCode,
    status.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['uid'] = nativeToJson<String>(uid);
    json['nome'] = nativeToJson<String>(nome);
    json['email'] = nativeToJson<String>(email);
    if (telefone != null) {
      json['telefone'] = nativeToJson<String?>(telefone);
    }
    json['papel'] = nativeToJson<String>(papel);
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  const GetMyProfileUsuario({
    required this.uid,
    required this.nome,
    required this.email,
    this.telefone,
    required this.papel,
    required this.status,
  });
}

@immutable
class GetMyProfileData {
  final GetMyProfileUsuario? usuario;
  GetMyProfileData.fromJson(dynamic json)
    : usuario = json['usuario'] == null
          ? null
          : GetMyProfileUsuario.fromJson(json['usuario']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyProfileData otherTyped = other as GetMyProfileData;
    return usuario == otherTyped.usuario;
  }

  @override
  int get hashCode => usuario.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (usuario != null) {
      json['usuario'] = usuario!.toJson();
    }
    return json;
  }

  const GetMyProfileData({this.usuario});
}
