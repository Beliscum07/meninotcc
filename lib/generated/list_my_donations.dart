part of 'example.dart';

class ListMyDonationsVariablesBuilder {
  final FirebaseDataConnect _dataConnect;
  ListMyDonationsVariablesBuilder(this._dataConnect);
  Deserializer<ListMyDonationsData> dataDeserializer = (dynamic json) =>
      ListMyDonationsData.fromJson(jsonDecode(json));

  Future<QueryResult<ListMyDonationsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<ListMyDonationsData, void> ref() {
    return _dataConnect.query(
      "ListMyDonations",
      dataDeserializer,
      emptySerializer,
      null,
    );
  }
}

@immutable
class ListMyDonationsDoacoes {
  final String id;
  final double valor;
  final Timestamp data;
  final String? metodo;
  final String status;
  ListMyDonationsDoacoes.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']),
      valor = nativeFromJson<double>(json['valor']),
      data = Timestamp.fromJson(json['data']),
      metodo = json['metodo'] == null
          ? null
          : nativeFromJson<String>(json['metodo']),
      status = nativeFromJson<String>(json['status']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyDonationsDoacoes otherTyped = other as ListMyDonationsDoacoes;
    return id == otherTyped.id &&
        valor == otherTyped.valor &&
        data == otherTyped.data &&
        metodo == otherTyped.metodo &&
        status == otherTyped.status;
  }

  @override
  int get hashCode => Object.hashAll([
    id.hashCode,
    valor.hashCode,
    data.hashCode,
    metodo.hashCode,
    status.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['valor'] = nativeToJson<double>(valor);
    json['data'] = data.toJson();
    if (metodo != null) {
      json['metodo'] = nativeToJson<String?>(metodo);
    }
    json['status'] = nativeToJson<String>(status);
    return json;
  }

  const ListMyDonationsDoacoes({
    required this.id,
    required this.valor,
    required this.data,
    this.metodo,
    required this.status,
  });
}

@immutable
class ListMyDonationsData {
  final List<ListMyDonationsDoacoes> doacoes;
  ListMyDonationsData.fromJson(dynamic json)
    : doacoes = (json['doacoes'] as List<dynamic>)
          .map((e) => ListMyDonationsDoacoes.fromJson(e))
          .toList();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyDonationsData otherTyped = other as ListMyDonationsData;
    return doacoes == otherTyped.doacoes;
  }

  @override
  int get hashCode => doacoes.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['doacoes'] = doacoes.map((e) => e.toJson()).toList();
    return json;
  }

  const ListMyDonationsData({required this.doacoes});
}
