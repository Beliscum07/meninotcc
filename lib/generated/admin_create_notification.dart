part of 'example.dart';

class AdminCreateNotificationVariablesBuilder {
  String destinatarioUid;
  String titulo;
  String mensagem;

  final FirebaseDataConnect _dataConnect;
  AdminCreateNotificationVariablesBuilder(
    this._dataConnect, {
    required this.destinatarioUid,
    required this.titulo,
    required this.mensagem,
  });
  Deserializer<AdminCreateNotificationData> dataDeserializer = (dynamic json) =>
      AdminCreateNotificationData.fromJson(jsonDecode(json));
  Serializer<AdminCreateNotificationVariables> varsSerializer =
      (AdminCreateNotificationVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<
      AdminCreateNotificationData,
      AdminCreateNotificationVariables
    >
  >
  execute() {
    return ref().execute();
  }

  MutationRef<AdminCreateNotificationData, AdminCreateNotificationVariables>
  ref() {
    AdminCreateNotificationVariables vars = AdminCreateNotificationVariables(
      destinatarioUid: destinatarioUid,
      titulo: titulo,
      mensagem: mensagem,
    );
    return _dataConnect.mutation(
      "AdminCreateNotification",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class AdminCreateNotificationNotificacaoInsert {
  final String id;
  AdminCreateNotificationNotificacaoInsert.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateNotificationNotificacaoInsert otherTyped =
        other as AdminCreateNotificationNotificacaoInsert;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const AdminCreateNotificationNotificacaoInsert({required this.id});
}

@immutable
class AdminCreateNotificationData {
  final AdminCreateNotificationNotificacaoInsert notificacao_insert;
  AdminCreateNotificationData.fromJson(dynamic json)
    : notificacao_insert = AdminCreateNotificationNotificacaoInsert.fromJson(
        json['notificacao_insert'],
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateNotificationData otherTyped =
        other as AdminCreateNotificationData;
    return notificacao_insert == otherTyped.notificacao_insert;
  }

  @override
  int get hashCode => notificacao_insert.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['notificacao_insert'] = notificacao_insert.toJson();
    return json;
  }

  const AdminCreateNotificationData({required this.notificacao_insert});
}

@immutable
class AdminCreateNotificationVariables {
  final String destinatarioUid;
  final String titulo;
  final String mensagem;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  AdminCreateNotificationVariables.fromJson(Map<String, dynamic> json)
    : destinatarioUid = nativeFromJson<String>(json['destinatarioUid']),
      titulo = nativeFromJson<String>(json['titulo']),
      mensagem = nativeFromJson<String>(json['mensagem']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateNotificationVariables otherTyped =
        other as AdminCreateNotificationVariables;
    return destinatarioUid == otherTyped.destinatarioUid &&
        titulo == otherTyped.titulo &&
        mensagem == otherTyped.mensagem;
  }

  @override
  int get hashCode => Object.hashAll([
    destinatarioUid.hashCode,
    titulo.hashCode,
    mensagem.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['destinatarioUid'] = nativeToJson<String>(destinatarioUid);
    json['titulo'] = nativeToJson<String>(titulo);
    json['mensagem'] = nativeToJson<String>(mensagem);
    return json;
  }

  const AdminCreateNotificationVariables({
    required this.destinatarioUid,
    required this.titulo,
    required this.mensagem,
  });
}
