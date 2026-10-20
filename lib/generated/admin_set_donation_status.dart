part of 'example.dart';

class AdminSetDonationStatusVariablesBuilder {
  String id;
  String status;

  final FirebaseDataConnect _dataConnect;
  AdminSetDonationStatusVariablesBuilder(
    this._dataConnect, {
    required this.id,
    required this.status,
  });
  Deserializer<AdminSetDonationStatusData> dataDeserializer = (dynamic json) =>
      AdminSetDonationStatusData.fromJson(jsonDecode(json));
  Serializer<AdminSetDonationStatusVariables> varsSerializer =
      (AdminSetDonationStatusVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<AdminSetDonationStatusData, AdminSetDonationStatusVariables>
  >
  execute() {
    return ref().execute();
  }

  MutationRef<AdminSetDonationStatusData, AdminSetDonationStatusVariables>
  ref() {
    AdminSetDonationStatusVariables vars = AdminSetDonationStatusVariables(
      id: id,
      status: status,
    );
    return _dataConnect.mutation(
      "AdminSetDonationStatus",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class AdminSetDonationStatusDoacaoUpdate {
  final String id;
  AdminSetDonationStatusDoacaoUpdate.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminSetDonationStatusDoacaoUpdate otherTyped =
        other as AdminSetDonationStatusDoacaoUpdate;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const AdminSetDonationStatusDoacaoUpdate({required this.id});
}

@immutable
class AdminSetDonationStatusData {
  final AdminSetDonationStatusDoacaoUpdate? doacao_update;
  AdminSetDonationStatusData.fromJson(dynamic json)
    : doacao_update = json['doacao_update'] == null
          ? null
          : AdminSetDonationStatusDoacaoUpdate.fromJson(json['doacao_update']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminSetDonationStatusData otherTyped =
        other as AdminSetDonationStatusData;
    return doacao_update == otherTyped.doacao_update;
  }

  @override
  int get hashCode => doacao_update.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (doacao_update != null) {
      json['doacao_update'] = doacao_update!.toJson();
    }
    return json;
  }

  const AdminSetDonationStatusData({this.doacao_update});
}

@immutable
class AdminSetDonationStatusVariables {
  final String id;
  final String status;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  AdminSetDonationStatusVariables.fromJson(Map<String, dynamic> json)
    : id = nativeFromJson<String>(json['id']),
      status = nativeFromJson<String>(json['status']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminSetDonationStatusVariables otherTyped =
        other as AdminSetDonationStatusVariables;
    return id == otherTyped.id && status == otherTyped.status;
  }

  @override
  int get hashCode => Object.hashAll([id.hashCode, status.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  const AdminSetDonationStatusVariables({
    required this.id,
    required this.status,
  });
}
