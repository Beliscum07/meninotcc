part of 'example.dart';

class GetMyNotificationsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetMyNotificationsVariablesBuilder(this._dataConnect, );
  Deserializer<GetMyNotificationsData> dataDeserializer = (dynamic json)  => GetMyNotificationsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetMyNotificationsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetMyNotificationsData, void> ref() {
    
    return _dataConnect.query("GetMyNotifications", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetMyNotificationsNotificacoes {
  final String id;
  final String titulo;
  final String mensagem;
  final bool lida;
  final Timestamp dataCriacao;
  GetMyNotificationsNotificacoes.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  titulo = nativeFromJson<String>(json['titulo']),
  mensagem = nativeFromJson<String>(json['mensagem']),
  lida = nativeFromJson<bool>(json['lida']),
  dataCriacao = Timestamp.fromJson(json['dataCriacao']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyNotificationsNotificacoes otherTyped = other as GetMyNotificationsNotificacoes;
    return id == otherTyped.id && 
    titulo == otherTyped.titulo && 
    mensagem == otherTyped.mensagem && 
    lida == otherTyped.lida && 
    dataCriacao == otherTyped.dataCriacao;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, titulo.hashCode, mensagem.hashCode, lida.hashCode, dataCriacao.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['titulo'] = nativeToJson<String>(titulo);
    json['mensagem'] = nativeToJson<String>(mensagem);
    json['lida'] = nativeToJson<bool>(lida);
    json['dataCriacao'] = dataCriacao.toJson();
    return json;
  }

  GetMyNotificationsNotificacoes({
    required this.id,
    required this.titulo,
    required this.mensagem,
    required this.lida,
    required this.dataCriacao,
  });
}

@immutable
class GetMyNotificationsData {
  final List<GetMyNotificationsNotificacoes> notificacoes;
  GetMyNotificationsData.fromJson(dynamic json):
  
  notificacoes = (json['notificacoes'] as List<dynamic>)
        .map((e) => GetMyNotificationsNotificacoes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyNotificationsData otherTyped = other as GetMyNotificationsData;
    return notificacoes == otherTyped.notificacoes;
    
  }
  @override
  int get hashCode => notificacoes.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['notificacoes'] = notificacoes.map((e) => e.toJson()).toList();
    return json;
  }

  GetMyNotificationsData({
    required this.notificacoes,
  });
}

