part of 'example.dart';

class AdminUpdateActivityVariablesBuilder {
  String id;
  String nome;
  String professor;
  Optional<String> _descricao = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _horario = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _dias = Optional.optional(nativeFromJson, nativeToJson);
  int vagas;
  Optional<String> _categoria = Optional.optional(nativeFromJson, nativeToJson);
  String status;

  final FirebaseDataConnect _dataConnect;  AdminUpdateActivityVariablesBuilder descricao(String? t) {
   _descricao.value = t;
   return this;
  }
  AdminUpdateActivityVariablesBuilder horario(String? t) {
   _horario.value = t;
   return this;
  }
  AdminUpdateActivityVariablesBuilder dias(String? t) {
   _dias.value = t;
   return this;
  }
  AdminUpdateActivityVariablesBuilder categoria(String? t) {
   _categoria.value = t;
   return this;
  }

  AdminUpdateActivityVariablesBuilder(this._dataConnect, {required  this.id,required  this.nome,required  this.professor,required  this.vagas,required  this.status,});
  Deserializer<AdminUpdateActivityData> dataDeserializer = (dynamic json)  => AdminUpdateActivityData.fromJson(jsonDecode(json));
  Serializer<AdminUpdateActivityVariables> varsSerializer = (AdminUpdateActivityVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AdminUpdateActivityData, AdminUpdateActivityVariables>> execute() {
    return ref().execute();
  }

  MutationRef<AdminUpdateActivityData, AdminUpdateActivityVariables> ref() {
    AdminUpdateActivityVariables vars= AdminUpdateActivityVariables(id: id,nome: nome,professor: professor,descricao: _descricao,horario: _horario,dias: _dias,vagas: vagas,categoria: _categoria,status: status,);
    return _dataConnect.mutation("AdminUpdateActivity", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class AdminUpdateActivityAtividadeUpdate {
  final String id;
  AdminUpdateActivityAtividadeUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminUpdateActivityAtividadeUpdate otherTyped = other as AdminUpdateActivityAtividadeUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  AdminUpdateActivityAtividadeUpdate({
    required this.id,
  });
}

@immutable
class AdminUpdateActivityData {
  final AdminUpdateActivityAtividadeUpdate? atividade_update;
  AdminUpdateActivityData.fromJson(dynamic json):
  
  atividade_update = json['atividade_update'] == null ? null : AdminUpdateActivityAtividadeUpdate.fromJson(json['atividade_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminUpdateActivityData otherTyped = other as AdminUpdateActivityData;
    return atividade_update == otherTyped.atividade_update;
    
  }
  @override
  int get hashCode => atividade_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (atividade_update != null) {
      json['atividade_update'] = atividade_update!.toJson();
    }
    return json;
  }

  AdminUpdateActivityData({
    this.atividade_update,
  });
}

@immutable
class AdminUpdateActivityVariables {
  final String id;
  final String nome;
  final String professor;
  late final Optional<String>descricao;
  late final Optional<String>horario;
  late final Optional<String>dias;
  final int vagas;
  late final Optional<String>categoria;
  final String status;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  AdminUpdateActivityVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  professor = nativeFromJson<String>(json['professor']),
  vagas = nativeFromJson<int>(json['vagas']),
  status = nativeFromJson<String>(json['status']) {
  
  
  
  
  
    descricao = Optional.optional(nativeFromJson, nativeToJson);
    descricao.value = json['descricao'] == null ? null : nativeFromJson<String>(json['descricao']);
  
  
    horario = Optional.optional(nativeFromJson, nativeToJson);
    horario.value = json['horario'] == null ? null : nativeFromJson<String>(json['horario']);
  
  
    dias = Optional.optional(nativeFromJson, nativeToJson);
    dias.value = json['dias'] == null ? null : nativeFromJson<String>(json['dias']);
  
  
  
    categoria = Optional.optional(nativeFromJson, nativeToJson);
    categoria.value = json['categoria'] == null ? null : nativeFromJson<String>(json['categoria']);
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final AdminUpdateActivityVariables otherTyped = other as AdminUpdateActivityVariables;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    professor == otherTyped.professor && 
    descricao == otherTyped.descricao && 
    horario == otherTyped.horario && 
    dias == otherTyped.dias && 
    vagas == otherTyped.vagas && 
    categoria == otherTyped.categoria && 
    status == otherTyped.status;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, professor.hashCode, descricao.hashCode, horario.hashCode, dias.hashCode, vagas.hashCode, categoria.hashCode, status.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    json['professor'] = nativeToJson<String>(professor);
    if(descricao.state == OptionalState.set) {
      json['descricao'] = descricao.toJson();
    }
    if(horario.state == OptionalState.set) {
      json['horario'] = horario.toJson();
    }
    if(dias.state == OptionalState.set) {
      json['dias'] = dias.toJson();
    }
    json['vagas'] = nativeToJson<int>(vagas);
    if(categoria.state == OptionalState.set) {
      json['categoria'] = categoria.toJson();
    }
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  AdminUpdateActivityVariables({
    required this.id,
    required this.nome,
    required this.professor,
    required this.descricao,
    required this.horario,
    required this.dias,
    required this.vagas,
    required this.categoria,
    required this.status,
  });
}

