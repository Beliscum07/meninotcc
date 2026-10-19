part of 'example.dart';

class AdminAssignActivityVariablesBuilder {
  String alunoId;
  String atividadeId;

  final FirebaseDataConnect _dataConnect;
  AdminAssignActivityVariablesBuilder(this._dataConnect, {required  this.alunoId,required  this.atividadeId,});
  Deserializer<AdminAssignActivityData> dataDeserializer = (dynamic json)  => AdminAssignActivityData.fromJson(jsonDecode(json));
  Serializer<AdminAssignActivityVariables> varsSerializer = (AdminAssignActivityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AdminAssignActivityData, AdminAssignActivityVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AdminAssignActivityData, AdminAssignActivityVariables> ref() {
    AdminAssignActivityVariables vars= AdminAssignActivityVariables(alunoId: alunoId,atividadeId: atividadeId,);
    return _dataConnect.mutation("AdminAssignActivity", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AdminAssignActivityInscricaoInsert {
  final String alunoId;
  final String atividadeId;
  AdminAssignActivityInscricaoInsert.fromJson(dynamic json):
  
  alunoId = nativeFromJson<String>(json['alunoId']),
  atividadeId = nativeFromJson<String>(json['atividadeId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminAssignActivityInscricaoInsert otherTyped = other as AdminAssignActivityInscricaoInsert;
    return alunoId == otherTyped.alunoId && 
    atividadeId == otherTyped.atividadeId;
    
  }
  @override
  int get hashCode => Object.hashAll([alunoId.hashCode, atividadeId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alunoId'] = nativeToJson<String>(alunoId);
    json['atividadeId'] = nativeToJson<String>(atividadeId);
    return json;
  }

  AdminAssignActivityInscricaoInsert({
    required this.alunoId,
    required this.atividadeId,
  });
}

@immutable
class AdminAssignActivityData {
  final AdminAssignActivityInscricaoInsert inscricao_insert;
  AdminAssignActivityData.fromJson(dynamic json):
  
  inscricao_insert = AdminAssignActivityInscricaoInsert.fromJson(json['inscricao_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminAssignActivityData otherTyped = other as AdminAssignActivityData;
    return inscricao_insert == otherTyped.inscricao_insert;
    
  }
  @override
  int get hashCode => inscricao_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['inscricao_insert'] = inscricao_insert.toJson();
    return json;
  }

  AdminAssignActivityData({
    required this.inscricao_insert,
  });
}

@immutable
class AdminAssignActivityVariables {
  final String alunoId;
  final String atividadeId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AdminAssignActivityVariables.fromJson(Map<String, dynamic> json):
  
  alunoId = nativeFromJson<String>(json['alunoId']),
  atividadeId = nativeFromJson<String>(json['atividadeId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminAssignActivityVariables otherTyped = other as AdminAssignActivityVariables;
    return alunoId == otherTyped.alunoId && 
    atividadeId == otherTyped.atividadeId;
    
  }
  @override
  int get hashCode => Object.hashAll([alunoId.hashCode, atividadeId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alunoId'] = nativeToJson<String>(alunoId);
    json['atividadeId'] = nativeToJson<String>(atividadeId);
    return json;
  }

  AdminAssignActivityVariables({
    required this.alunoId,
    required this.atividadeId,
  });
}

