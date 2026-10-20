// ignore_for_file: non_constant_identifier_names
// These names preserve generated GraphQL field aliases.
part of 'example.dart';

class ListScholarshipsVariablesBuilder {
  final FirebaseDataConnect _dataConnect;
  ListScholarshipsVariablesBuilder(this._dataConnect);
  Deserializer<ListScholarshipsData> dataDeserializer = (dynamic json) =>
      ListScholarshipsData.fromJson(jsonDecode(json));

  Future<QueryResult<ListScholarshipsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListScholarshipsData, void> ref() {
    return _dataConnect.query(
      "ListScholarships",
      dataDeserializer,
      emptySerializer,
      null,
    );
  }
}

@immutable
class ListScholarshipsBolsas {
  final String id;
  final String nome;
  final String? descricao;
  final double valorMensal;
  final bool ativa;
  final List<ListScholarshipsBolsasAlunoBolsasOnBolsa> alunoBolsas_on_bolsa;
  ListScholarshipsBolsas.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']),
      nome = nativeFromJson<String>(json['nome']),
      descricao = json['descricao'] == null
          ? null
          : nativeFromJson<String>(json['descricao']),
      valorMensal = nativeFromJson<double>(json['valorMensal']),
      ativa = nativeFromJson<bool>(json['ativa']),
      alunoBolsas_on_bolsa = (json['alunoBolsas_on_bolsa'] as List<dynamic>)
          .map((e) => ListScholarshipsBolsasAlunoBolsasOnBolsa.fromJson(e))
          .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListScholarshipsBolsas otherTyped = other as ListScholarshipsBolsas;
    return id == otherTyped.id &&
        nome == otherTyped.nome &&
        descricao == otherTyped.descricao &&
        valorMensal == otherTyped.valorMensal &&
        ativa == otherTyped.ativa &&
        alunoBolsas_on_bolsa == otherTyped.alunoBolsas_on_bolsa;
  }

  @override
  int get hashCode => Object.hashAll([
    id.hashCode,
    nome.hashCode,
    descricao.hashCode,
    valorMensal.hashCode,
    ativa.hashCode,
    alunoBolsas_on_bolsa.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    if (descricao != null) {
      json['descricao'] = nativeToJson<String?>(descricao);
    }
    json['valorMensal'] = nativeToJson<double>(valorMensal);
    json['ativa'] = nativeToJson<bool>(ativa);
    json['alunoBolsas_on_bolsa'] = alunoBolsas_on_bolsa
        .map((e) => e.toJson())
        .toList();
    return json;
  }

  const ListScholarshipsBolsas({
    required this.id,
    required this.nome,
    this.descricao,
    required this.valorMensal,
    required this.ativa,
    required this.alunoBolsas_on_bolsa,
  });
}

@immutable
class ListScholarshipsBolsasAlunoBolsasOnBolsa {
  final String alunoId;
  final double valorConcedido;
  ListScholarshipsBolsasAlunoBolsasOnBolsa.fromJson(dynamic json)
    : alunoId = nativeFromJson<String>(json['alunoId']),
      valorConcedido = nativeFromJson<double>(json['valorConcedido']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListScholarshipsBolsasAlunoBolsasOnBolsa otherTyped =
        other as ListScholarshipsBolsasAlunoBolsasOnBolsa;
    return alunoId == otherTyped.alunoId &&
        valorConcedido == otherTyped.valorConcedido;
  }

  @override
  int get hashCode =>
      Object.hashAll([alunoId.hashCode, valorConcedido.hashCode]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alunoId'] = nativeToJson<String>(alunoId);
    json['valorConcedido'] = nativeToJson<double>(valorConcedido);
    return json;
  }

  const ListScholarshipsBolsasAlunoBolsasOnBolsa({
    required this.alunoId,
    required this.valorConcedido,
  });
}

@immutable
class ListScholarshipsData {
  final List<ListScholarshipsBolsas> bolsas;
  ListScholarshipsData.fromJson(dynamic json)
    : bolsas = (json['bolsas'] as List<dynamic>)
          .map((e) => ListScholarshipsBolsas.fromJson(e))
          .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListScholarshipsData otherTyped = other as ListScholarshipsData;
    return bolsas == otherTyped.bolsas;
  }

  @override
  int get hashCode => bolsas.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['bolsas'] = bolsas.map((e) => e.toJson()).toList();
    return json;
  }

  const ListScholarshipsData({required this.bolsas});
}
