part of 'example.dart';

class ListDonationsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListDonationsVariablesBuilder(this._dataConnect, );
  Deserializer<ListDonationsData> dataDeserializer = (dynamic json)  => ListDonationsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListDonationsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListDonationsData, void> ref() {
    
    return _dataConnect.query("ListDonations", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListDonationsDoacoes {
  final String id;
  final double valor;
  final Timestamp data;
  final String? metodo;
  final String status;
  final ListDonationsDoacoesDoador doador;
  ListDonationsDoacoes.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  valor = nativeFromJson<double>(json['valor']),
  data = Timestamp.fromJson(json['data']),
  metodo = json['metodo'] == null ? null : nativeFromJson<String>(json['metodo']),
  status = nativeFromJson<String>(json['status']),
  doador = ListDonationsDoacoesDoador.fromJson(json['doador']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListDonationsDoacoes otherTyped = other as ListDonationsDoacoes;
    return id == otherTyped.id && 
    valor == otherTyped.valor && 
    data == otherTyped.data && 
    metodo == otherTyped.metodo && 
    status == otherTyped.status && 
    doador == otherTyped.doador;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, valor.hashCode, data.hashCode, metodo.hashCode, status.hashCode, doador.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['valor'] = nativeToJson<double>(valor);
    json['data'] = data.toJson();
    if (metodo != null) {
      json['metodo'] = nativeToJson<String?>(metodo);
    }
    json['status'] = nativeToJson<String>(status);
    json['doador'] = doador.toJson();
    return json;
  }

  ListDonationsDoacoes({
    required this.id,
    required this.valor,
    required this.data,
    this.metodo,
    required this.status,
    required this.doador,
  });
}

@immutable
class ListDonationsDoacoesDoador {
  final ListDonationsDoacoesDoadorUsuario usuario;
  ListDonationsDoacoesDoador.fromJson(dynamic json):
  
  usuario = ListDonationsDoacoesDoadorUsuario.fromJson(json['usuario']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListDonationsDoacoesDoador otherTyped = other as ListDonationsDoacoesDoador;
    return usuario == otherTyped.usuario;
    
  }
  @override
  int get hashCode => usuario.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['usuario'] = usuario.toJson();
    return json;
  }

  ListDonationsDoacoesDoador({
    required this.usuario,
  });
}

@immutable
class ListDonationsDoacoesDoadorUsuario {
  final String nome;
  final String email;
  ListDonationsDoacoesDoadorUsuario.fromJson(dynamic json):
  
  nome = nativeFromJson<String>(json['nome']),
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListDonationsDoacoesDoadorUsuario otherTyped = other as ListDonationsDoacoesDoadorUsuario;
    return nome == otherTyped.nome && 
    email == otherTyped.email;
    
  }
  @override
  int get hashCode => Object.hashAll([nome.hashCode, email.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  ListDonationsDoacoesDoadorUsuario({
    required this.nome,
    required this.email,
  });
}

@immutable
class ListDonationsData {
  final List<ListDonationsDoacoes> doacoes;
  ListDonationsData.fromJson(dynamic json):
  
  doacoes = (json['doacoes'] as List<dynamic>)
        .map((e) => ListDonationsDoacoes.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListDonationsData otherTyped = other as ListDonationsData;
    return doacoes == otherTyped.doacoes;
    
  }
  @override
  int get hashCode => doacoes.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['doacoes'] = doacoes.map((e) => e.toJson()).toList();
    return json;
  }

  ListDonationsData({
    required this.doacoes,
  });
}

