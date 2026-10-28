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
class AdminAssignActivityAtividadeUpdate {
  final String id;
  AdminAssignActivityAtividadeUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminAssignActivityAtividadeUpdate otherTyped = other as AdminAssignActivityAtividadeUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AdminAssignActivityAtividadeUpdate({
    required this.id,
  });
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
  final AdminAssignActivityAtividadeUpdate? atividade_update;
  final AdminAssignActivityInscricaoInsert inscricao_insert;
  AdminAssignActivityData.fromJson(dynamic json):
  
  atividade_update = json['atividade_update'] == null ? null : AdminAssignActivityAtividadeUpdate.fromJson(json['atividade_update']),
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
    return atividade_update == otherTyped.atividade_update && 
    inscricao_insert == otherTyped.inscricao_insert;
    
  }
  @override
  int get hashCode => Object.hashAll([atividade_update.hashCode, inscricao_insert.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (atividade_update != null) {
      json['atividade_update'] = atividade_update!.toJson();
    }
    json['inscricao_insert'] = inscricao_insert.toJson();
    return json;
  }

  AdminAssignActivityData({
    this.atividade_update,
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

