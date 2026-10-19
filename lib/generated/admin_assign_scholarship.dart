part of 'example.dart';

class AdminAssignScholarshipVariablesBuilder {
  String alunoId;
  String bolsaId;
  double valorConcedido;

  final FirebaseDataConnect _dataConnect;
  AdminAssignScholarshipVariablesBuilder(this._dataConnect, {required  this.alunoId,required  this.bolsaId,required  this.valorConcedido,});
  Deserializer<AdminAssignScholarshipData> dataDeserializer = (dynamic json)  => AdminAssignScholarshipData.fromJson(jsonDecode(json));
  Serializer<AdminAssignScholarshipVariables> varsSerializer = (AdminAssignScholarshipVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AdminAssignScholarshipData, AdminAssignScholarshipVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AdminAssignScholarshipData, AdminAssignScholarshipVariables> ref() {
    AdminAssignScholarshipVariables vars= AdminAssignScholarshipVariables(alunoId: alunoId,bolsaId: bolsaId,valorConcedido: valorConcedido,);
    return _dataConnect.mutation("AdminAssignScholarship", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AdminAssignScholarshipAlunoBolsaUpsert {
  final String alunoId;
  final String bolsaId;
  AdminAssignScholarshipAlunoBolsaUpsert.fromJson(dynamic json):
  
  alunoId = nativeFromJson<String>(json['alunoId']),
  bolsaId = nativeFromJson<String>(json['bolsaId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminAssignScholarshipAlunoBolsaUpsert otherTyped = other as AdminAssignScholarshipAlunoBolsaUpsert;
    return alunoId == otherTyped.alunoId && 
    bolsaId == otherTyped.bolsaId;
    
  }
  @override
  int get hashCode => Object.hashAll([alunoId.hashCode, bolsaId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alunoId'] = nativeToJson<String>(alunoId);
    json['bolsaId'] = nativeToJson<String>(bolsaId);
    return json;
  }

  AdminAssignScholarshipAlunoBolsaUpsert({
    required this.alunoId,
    required this.bolsaId,
  });
}

@immutable
class AdminAssignScholarshipData {
  final AdminAssignScholarshipAlunoBolsaUpsert alunoBolsa_upsert;
  AdminAssignScholarshipData.fromJson(dynamic json):
  
  alunoBolsa_upsert = AdminAssignScholarshipAlunoBolsaUpsert.fromJson(json['alunoBolsa_upsert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminAssignScholarshipData otherTyped = other as AdminAssignScholarshipData;
    return alunoBolsa_upsert == otherTyped.alunoBolsa_upsert;
    
  }
  @override
  int get hashCode => alunoBolsa_upsert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alunoBolsa_upsert'] = alunoBolsa_upsert.toJson();
    return json;
  }

  AdminAssignScholarshipData({
    required this.alunoBolsa_upsert,
  });
}

@immutable
class AdminAssignScholarshipVariables {
  final String alunoId;
  final String bolsaId;
  final double valorConcedido;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AdminAssignScholarshipVariables.fromJson(Map<String, dynamic> json):
  
  alunoId = nativeFromJson<String>(json['alunoId']),
  bolsaId = nativeFromJson<String>(json['bolsaId']),
  valorConcedido = nativeFromJson<double>(json['valorConcedido']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminAssignScholarshipVariables otherTyped = other as AdminAssignScholarshipVariables;
    return alunoId == otherTyped.alunoId && 
    bolsaId == otherTyped.bolsaId && 
    valorConcedido == otherTyped.valorConcedido;
    
  }
  @override
  int get hashCode => Object.hashAll([alunoId.hashCode, bolsaId.hashCode, valorConcedido.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alunoId'] = nativeToJson<String>(alunoId);
    json['bolsaId'] = nativeToJson<String>(bolsaId);
    json['valorConcedido'] = nativeToJson<double>(valorConcedido);
    return json;
  }

  AdminAssignScholarshipVariables({
    required this.alunoId,
    required this.bolsaId,
    required this.valorConcedido,
  });
}

