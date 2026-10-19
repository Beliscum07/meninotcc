part of 'example.dart';

class AdminLinkStudentAccountVariablesBuilder {
  String studentId;
  String authUid;
  String authEmail;

  final FirebaseDataConnect _dataConnect;
  AdminLinkStudentAccountVariablesBuilder(this._dataConnect, {required  this.studentId,required  this.authUid,required  this.authEmail,});
  Deserializer<AdminLinkStudentAccountData> dataDeserializer = (dynamic json)  => AdminLinkStudentAccountData.fromJson(jsonDecode(json));
  Serializer<AdminLinkStudentAccountVariables> varsSerializer = (AdminLinkStudentAccountVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AdminLinkStudentAccountData, AdminLinkStudentAccountVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AdminLinkStudentAccountData, AdminLinkStudentAccountVariables> ref() {
    AdminLinkStudentAccountVariables vars= AdminLinkStudentAccountVariables(studentId: studentId,authUid: authUid,authEmail: authEmail,);
    return _dataConnect.mutation("AdminLinkStudentAccount", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AdminLinkStudentAccountUsuarioInsert {
  final String uid;
  AdminLinkStudentAccountUsuarioInsert.fromJson(dynamic json):
  
  uid = nativeFromJson<String>(json['uid']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminLinkStudentAccountUsuarioInsert otherTyped = other as AdminLinkStudentAccountUsuarioInsert;
    return uid == otherTyped.uid;
    
  }
  @override
  int get hashCode => uid.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['uid'] = nativeToJson<String>(uid);
    return json;
  }

  AdminLinkStudentAccountUsuarioInsert({
    required this.uid,
  });
}

@immutable
class AdminLinkStudentAccountAlunoUpdate {
  final String id;
  AdminLinkStudentAccountAlunoUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminLinkStudentAccountAlunoUpdate otherTyped = other as AdminLinkStudentAccountAlunoUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AdminLinkStudentAccountAlunoUpdate({
    required this.id,
  });
}

@immutable
class AdminLinkStudentAccountData {
  final AdminLinkStudentAccountUsuarioInsert usuario_insert;
  final AdminLinkStudentAccountAlunoUpdate? aluno_update;
  AdminLinkStudentAccountData.fromJson(dynamic json):
  
  usuario_insert = AdminLinkStudentAccountUsuarioInsert.fromJson(json['usuario_insert']),
  aluno_update = json['aluno_update'] == null ? null : AdminLinkStudentAccountAlunoUpdate.fromJson(json['aluno_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminLinkStudentAccountData otherTyped = other as AdminLinkStudentAccountData;
    return usuario_insert == otherTyped.usuario_insert && 
    aluno_update == otherTyped.aluno_update;
    
  }
  @override
  int get hashCode => Object.hashAll([usuario_insert.hashCode, aluno_update.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['usuario_insert'] = usuario_insert.toJson();
    if (aluno_update != null) {
      json['aluno_update'] = aluno_update!.toJson();
    }
    return json;
  }

  AdminLinkStudentAccountData({
    required this.usuario_insert,
    this.aluno_update,
  });
}

@immutable
class AdminLinkStudentAccountVariables {
  final String studentId;
  final String authUid;
  final String authEmail;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AdminLinkStudentAccountVariables.fromJson(Map<String, dynamic> json):
  
  studentId = nativeFromJson<String>(json['studentId']),
  authUid = nativeFromJson<String>(json['authUid']),
  authEmail = nativeFromJson<String>(json['authEmail']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminLinkStudentAccountVariables otherTyped = other as AdminLinkStudentAccountVariables;
    return studentId == otherTyped.studentId && 
    authUid == otherTyped.authUid && 
    authEmail == otherTyped.authEmail;
    
  }
  @override
  int get hashCode => Object.hashAll([studentId.hashCode, authUid.hashCode, authEmail.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['studentId'] = nativeToJson<String>(studentId);
    json['authUid'] = nativeToJson<String>(authUid);
    json['authEmail'] = nativeToJson<String>(authEmail);
    return json;
  }

  AdminLinkStudentAccountVariables({
    required this.studentId,
    required this.authUid,
    required this.authEmail,
  });
}

