// ignore_for_file: non_constant_identifier_names

part of 'example.dart';

class AdminSetStudentStatusVariablesBuilder {
  String id;
  String status;

  final FirebaseDataConnect _dataConnect;
  AdminSetStudentStatusVariablesBuilder(
    this._dataConnect, {
    required this.id,
    required this.status,
  });
  Deserializer<AdminSetStudentStatusData> dataDeserializer = (dynamic json) =>
      AdminSetStudentStatusData.fromJson(jsonDecode(json));
  Serializer<AdminSetStudentStatusVariables> varsSerializer =
      (AdminSetStudentStatusVariables vars) => jsonEncode(vars.toJson());
  Future<
    OperationResult<AdminSetStudentStatusData, AdminSetStudentStatusVariables>
  >
  execute() {
    return ref().execute();
  }

  MutationRef<AdminSetStudentStatusData, AdminSetStudentStatusVariables> ref() {
    AdminSetStudentStatusVariables vars = AdminSetStudentStatusVariables(
      id: id,
      status: status,
    );
    return _dataConnect.mutation(
      "AdminSetStudentStatus",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class AdminSetStudentStatusAlunoUpdate {
  final String id;
  AdminSetStudentStatusAlunoUpdate.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminSetStudentStatusAlunoUpdate otherTyped =
        other as AdminSetStudentStatusAlunoUpdate;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const AdminSetStudentStatusAlunoUpdate({required this.id});
}

@immutable
class AdminSetStudentStatusData {
  final AdminSetStudentStatusAlunoUpdate? aluno_update;
  AdminSetStudentStatusData.fromJson(dynamic json)
    : aluno_update = json['aluno_update'] == null
          ? null
          : AdminSetStudentStatusAlunoUpdate.fromJson(json['aluno_update']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminSetStudentStatusData otherTyped =
        other as AdminSetStudentStatusData;
    return aluno_update == otherTyped.aluno_update;
  }

  @override
  int get hashCode => aluno_update.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (aluno_update != null) {
      json['aluno_update'] = aluno_update!.toJson();
    }
    return json;
  }

  const AdminSetStudentStatusData({this.aluno_update});
}

@immutable
class AdminSetStudentStatusVariables {
  final String id;
  final String status;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  AdminSetStudentStatusVariables.fromJson(Map<String, dynamic> json)
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

    final AdminSetStudentStatusVariables otherTyped =
        other as AdminSetStudentStatusVariables;
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

  const AdminSetStudentStatusVariables({
    required this.id,
    required this.status,
  });
}
