part of 'example.dart';

class ListMyScholarshipsVariablesBuilder {
  final FirebaseDataConnect _dataConnect;
  ListMyScholarshipsVariablesBuilder(this._dataConnect);
  Deserializer<ListMyScholarshipsData> dataDeserializer = (dynamic json) =>
      ListMyScholarshipsData.fromJson(jsonDecode(json));

  Future<QueryResult<ListMyScholarshipsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMyScholarshipsData, void> ref() {
    return _dataConnect.query(
      "ListMyScholarships",
      dataDeserializer,
      emptySerializer,
      null,
    );
  }
}

@immutable
class ListMyScholarshipsAlunoBolsas {
  final ListMyScholarshipsAlunoBolsasBolsa bolsa;
  final double valorConcedido;
  final Timestamp dataInicio;
  final Timestamp? dataFim;
  ListMyScholarshipsAlunoBolsas.fromJson(dynamic json)
    : bolsa = ListMyScholarshipsAlunoBolsasBolsa.fromJson(json['bolsa']),
      valorConcedido = nativeFromJson<double>(json['valorConcedido']),
      dataInicio = Timestamp.fromJson(json['dataInicio']),
      dataFim = json['dataFim'] == null
          ? null
          : Timestamp.fromJson(json['dataFim']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyScholarshipsAlunoBolsas otherTyped =
        other as ListMyScholarshipsAlunoBolsas;
    return bolsa == otherTyped.bolsa &&
        valorConcedido == otherTyped.valorConcedido &&
        dataInicio == otherTyped.dataInicio &&
        dataFim == otherTyped.dataFim;
  }

  @override
  int get hashCode => Object.hashAll([
    bolsa.hashCode,
    valorConcedido.hashCode,
    dataInicio.hashCode,
    dataFim.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['bolsa'] = bolsa.toJson();
    json['valorConcedido'] = nativeToJson<double>(valorConcedido);
    json['dataInicio'] = dataInicio.toJson();
    if (dataFim != null) {
      json['dataFim'] = dataFim!.toJson();
    }
    return json;
  }

  const ListMyScholarshipsAlunoBolsas({
    required this.bolsa,
    required this.valorConcedido,
    required this.dataInicio,
    this.dataFim,
  });
}

@immutable
class ListMyScholarshipsAlunoBolsasBolsa {
  final String id;
  final String nome;
  final String? descricao;
  final double valorMensal;
  ListMyScholarshipsAlunoBolsasBolsa.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']),
      nome = nativeFromJson<String>(json['nome']),
      descricao = json['descricao'] == null
          ? null
          : nativeFromJson<String>(json['descricao']),
      valorMensal = nativeFromJson<double>(json['valorMensal']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyScholarshipsAlunoBolsasBolsa otherTyped =
        other as ListMyScholarshipsAlunoBolsasBolsa;
    return id == otherTyped.id &&
        nome == otherTyped.nome &&
        descricao == otherTyped.descricao &&
        valorMensal == otherTyped.valorMensal;
  }

  @override
  int get hashCode => Object.hashAll([
    id.hashCode,
    nome.hashCode,
    descricao.hashCode,
    valorMensal.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    if (descricao != null) {
      json['descricao'] = nativeToJson<String?>(descricao);
    }
    json['valorMensal'] = nativeToJson<double>(valorMensal);
    return json;
  }

  const ListMyScholarshipsAlunoBolsasBolsa({
    required this.id,
    required this.nome,
    this.descricao,
    required this.valorMensal,
  });
}

@immutable
class ListMyScholarshipsData {
  final List<ListMyScholarshipsAlunoBolsas> alunoBolsas;
  ListMyScholarshipsData.fromJson(dynamic json)
    : alunoBolsas = (json['alunoBolsas'] as List<dynamic>)
          .map((e) => ListMyScholarshipsAlunoBolsas.fromJson(e))
          .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyScholarshipsData otherTyped = other as ListMyScholarshipsData;
    return alunoBolsas == otherTyped.alunoBolsas;
  }

  @override
  int get hashCode => alunoBolsas.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alunoBolsas'] = alunoBolsas.map((e) => e.toJson()).toList();
    return json;
  }

  const ListMyScholarshipsData({required this.alunoBolsas});
}
