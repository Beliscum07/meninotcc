part of 'example.dart';

class ListAgendaVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListAgendaVariablesBuilder(this._dataConnect, );
  Deserializer<ListAgendaData> dataDeserializer = (dynamic json)  => ListAgendaData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListAgendaData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListAgendaData, void> ref() {
    
    return _dataConnect.query("ListAgenda", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListAgendaAgendas {
  final String id;
  final String titulo;
  final String? descricao;
  final Timestamp inicio;
  final Timestamp? fim;
  final String? local;
  final ListAgendaAgendasAtividade? atividade;
  ListAgendaAgendas.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  titulo = nativeFromJson<String>(json['titulo']),
  descricao = json['descricao'] == null ? null : nativeFromJson<String>(json['descricao']),
  inicio = Timestamp.fromJson(json['inicio']),
  fim = json['fim'] == null ? null : Timestamp.fromJson(json['fim']),
  local = json['local'] == null ? null : nativeFromJson<String>(json['local']),
  atividade = json['atividade'] == null ? null : ListAgendaAgendasAtividade.fromJson(json['atividade']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAgendaAgendas otherTyped = other as ListAgendaAgendas;
    return id == otherTyped.id && 
    titulo == otherTyped.titulo && 
    descricao == otherTyped.descricao && 
    inicio == otherTyped.inicio && 
    fim == otherTyped.fim && 
    local == otherTyped.local && 
    atividade == otherTyped.atividade;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, titulo.hashCode, descricao.hashCode, inicio.hashCode, fim.hashCode, local.hashCode, atividade.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['titulo'] = nativeToJson<String>(titulo);
    if (descricao != null) {
      json['descricao'] = nativeToJson<String?>(descricao);
    }
    json['inicio'] = inicio.toJson();
    if (fim != null) {
      json['fim'] = fim!.toJson();
    }
    if (local != null) {
      json['local'] = nativeToJson<String?>(local);
    }
    if (atividade != null) {
      json['atividade'] = atividade!.toJson();
    }
    return json;
  }

  ListAgendaAgendas({
    required this.id,
    required this.titulo,
    this.descricao,
    required this.inicio,
    this.fim,
    this.local,
    this.atividade,
  });
}

@immutable
class ListAgendaAgendasAtividade {
  final String id;
  final String nome;
  ListAgendaAgendasAtividade.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAgendaAgendasAtividade otherTyped = other as ListAgendaAgendasAtividade;
    return id == otherTyped.id && 
    nome == otherTyped.nome;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    return json;
  }

  ListAgendaAgendasAtividade({
    required this.id,
    required this.nome,
  });
}

@immutable
class ListAgendaData {
  final List<ListAgendaAgendas> agendas;
  ListAgendaData.fromJson(dynamic json):
  
  agendas = (json['agendas'] as List<dynamic>)
        .map((e) => ListAgendaAgendas.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListAgendaData otherTyped = other as ListAgendaData;
    return agendas == otherTyped.agendas;
    
  }
  @override
  int get hashCode => agendas.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['agendas'] = agendas.map((e) => e.toJson()).toList();
    return json;
  }

  ListAgendaData({
    required this.agendas,
  });
}

