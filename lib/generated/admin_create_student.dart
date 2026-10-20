// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables

part of 'example.dart';

class AdminCreateStudentVariablesBuilder {
  String nome;
  int idade;
  String responsavel;
  String telefone;
  final Optional<String> _email = Optional.optional(
    nativeFromJson,
    nativeToJson,
  );
  int presenca;

  final FirebaseDataConnect _dataConnect;
  AdminCreateStudentVariablesBuilder email(String? t) {
    _email.value = t;
    return this;
  }

  AdminCreateStudentVariablesBuilder(
    this._dataConnect, {
    required this.nome,
    required this.idade,
    required this.responsavel,
    required this.telefone,
    required this.presenca,
  });
  Deserializer<AdminCreateStudentData> dataDeserializer = (dynamic json) =>
      AdminCreateStudentData.fromJson(jsonDecode(json));
  Serializer<AdminCreateStudentVariables> varsSerializer =
      (AdminCreateStudentVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AdminCreateStudentData, AdminCreateStudentVariables>>
  execute() {
    return ref().execute();
  }

  MutationRef<AdminCreateStudentData, AdminCreateStudentVariables> ref() {
    AdminCreateStudentVariables vars = AdminCreateStudentVariables(
      nome: nome,
      idade: idade,
      responsavel: responsavel,
      telefone: telefone,
      email: _email,
      presenca: presenca,
    );
    return _dataConnect.mutation(
      "AdminCreateStudent",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class AdminCreateStudentAlunoInsert {
  final String id;
  AdminCreateStudentAlunoInsert.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateStudentAlunoInsert otherTyped =
        other as AdminCreateStudentAlunoInsert;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const AdminCreateStudentAlunoInsert({required this.id});
}

@immutable
class AdminCreateStudentData {
  final AdminCreateStudentAlunoInsert aluno_insert;
  AdminCreateStudentData.fromJson(dynamic json)
    : aluno_insert = AdminCreateStudentAlunoInsert.fromJson(
        json['aluno_insert'],
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateStudentData otherTyped = other as AdminCreateStudentData;
    return aluno_insert == otherTyped.aluno_insert;
  }

  @override
  int get hashCode => aluno_insert.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['aluno_insert'] = aluno_insert.toJson();
    return json;
  }

  const AdminCreateStudentData({required this.aluno_insert});
}

@immutable
class AdminCreateStudentVariables {
  final String nome;
  final int idade;
  final String responsavel;
  final String telefone;
  late final Optional<String> email;
  final int presenca;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  AdminCreateStudentVariables.fromJson(Map<String, dynamic> json)
    : nome = nativeFromJson<String>(json['nome']),
      idade = nativeFromJson<int>(json['idade']),
      responsavel = nativeFromJson<String>(json['responsavel']),
      telefone = nativeFromJson<String>(json['telefone']),
      presenca = nativeFromJson<int>(json['presenca']) {
    email = Optional.optional(nativeFromJson, nativeToJson);
    email.value = json['email'] == null
        ? null
        : nativeFromJson<String>(json['email']);
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminCreateStudentVariables otherTyped =
        other as AdminCreateStudentVariables;
    return nome == otherTyped.nome &&
        idade == otherTyped.idade &&
        responsavel == otherTyped.responsavel &&
        telefone == otherTyped.telefone &&
        email == otherTyped.email &&
        presenca == otherTyped.presenca;
  }

  @override
  int get hashCode => Object.hashAll([
    nome.hashCode,
    idade.hashCode,
    responsavel.hashCode,
    telefone.hashCode,
    email.hashCode,
    presenca.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['nome'] = nativeToJson<String>(nome);
    json['idade'] = nativeToJson<int>(idade);
    json['responsavel'] = nativeToJson<String>(responsavel);
    json['telefone'] = nativeToJson<String>(telefone);
    if (email.state == OptionalState.set) {
      json['email'] = email.toJson();
    }
    json['presenca'] = nativeToJson<int>(presenca);
    return json;
  }

  AdminCreateStudentVariables({
    required this.nome,
    required this.idade,
    required this.responsavel,
    required this.telefone,
    required this.email,
    required this.presenca,
  });
}
