part of 'example.dart';

class MarkMyNotificationReadVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  MarkMyNotificationReadVariablesBuilder(this._dataConnect, {required this.id});
  Deserializer<MarkMyNotificationReadData> dataDeserializer = (dynamic json) =>
      MarkMyNotificationReadData.fromJson(jsonDecode(json));
  Serializer<MarkMyNotificationReadVariables> varsSerializer =
      (MarkMyNotificationReadVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<MarkMyNotificationReadData, MarkMyNotificationReadVariables>
  >
  execute() {
    return ref().execute();
  }

  MutationRef<MarkMyNotificationReadData, MarkMyNotificationReadVariables>
  ref() {
    MarkMyNotificationReadVariables vars = MarkMyNotificationReadVariables(
      id: id,
    );
    return _dataConnect.mutation(
      "MarkMyNotificationRead",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class MarkMyNotificationReadNotificacaoUpdate {
  final String id;
  MarkMyNotificationReadNotificacaoUpdate.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final MarkMyNotificationReadNotificacaoUpdate otherTyped =
        other as MarkMyNotificationReadNotificacaoUpdate;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const MarkMyNotificationReadNotificacaoUpdate({required this.id});
}

@immutable
class MarkMyNotificationReadData {
  final MarkMyNotificationReadNotificacaoUpdate? notificacao_update;
  MarkMyNotificationReadData.fromJson(dynamic json)
    : notificacao_update = json['notificacao_update'] == null
          ? null
          : MarkMyNotificationReadNotificacaoUpdate.fromJson(
              json['notificacao_update'],
            );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final MarkMyNotificationReadData otherTyped =
        other as MarkMyNotificationReadData;
    return notificacao_update == otherTyped.notificacao_update;
  }

  @override
  int get hashCode => notificacao_update.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (notificacao_update != null) {
      json['notificacao_update'] = notificacao_update!.toJson();
    }
    return json;
  }

  const MarkMyNotificationReadData({this.notificacao_update});
}

@immutable
class MarkMyNotificationReadVariables {
  final String id;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  MarkMyNotificationReadVariables.fromJson(Map<String, dynamic> json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final MarkMyNotificationReadVariables otherTyped =
        other as MarkMyNotificationReadVariables;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const MarkMyNotificationReadVariables({required this.id});
}
