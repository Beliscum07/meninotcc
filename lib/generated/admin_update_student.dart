part of 'example.dart';

class AdminUpdateStudentVariablesBuilder {
  String id;
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
  AdminUpdateStudentVariablesBuilder email(String? t) {
    _email.value = t;
    return this;
  }

  AdminUpdateStudentVariablesBuilder(
    this._dataConnect, {
    required this.id,
    required this.nome,
    required this.idade,
    required this.responsavel,
    required this.telefone,
    required this.presenca,
  });
  Deserializer<AdminUpdateStudentData> dataDeserializer = (dynamic json) =>
      AdminUpdateStudentData.fromJson(jsonDecode(json));
  Serializer<AdminUpdateStudentVariables> varsSerializer =
      (AdminUpdateStudentVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AdminUpdateStudentData, AdminUpdateStudentVariables>>
  execute() {
    return ref().execute();
  }

  MutationRef<AdminUpdateStudentData, AdminUpdateStudentVariables> ref() {
    AdminUpdateStudentVariables vars = AdminUpdateStudentVariables(
      id: id,
      nome: nome,
      idade: idade,
      responsavel: responsavel,
      telefone: telefone,
      email: _email,
      presenca: presenca,
    );
    return _dataConnect.mutation(
      "AdminUpdateStudent",
      dataDeserializer,
      varsSerializer,
      vars,
    );
  }
}

@immutable
class AdminUpdateStudentAlunoUpdate {
  final String id;
  AdminUpdateStudentAlunoUpdate.fromJson(dynamic json)
    : id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminUpdateStudentAlunoUpdate otherTyped =
        other as AdminUpdateStudentAlunoUpdate;
    return id == otherTyped.id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const AdminUpdateStudentAlunoUpdate({required this.id});
}

@immutable
class AdminUpdateStudentData {
  final AdminUpdateStudentAlunoUpdate? aluno_update;
  AdminUpdateStudentData.fromJson(dynamic json)
    : aluno_update = json['aluno_update'] == null
          ? null
          : AdminUpdateStudentAlunoUpdate.fromJson(json['aluno_update']);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    final AdminUpdateStudentData otherTyped = other as AdminUpdateStudentData;
    return aluno_update == otherTyped.aluno_update;
  }

  @override
  int get hashCode => aluno_update.hashCode;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (aluno_update != null) {
      json['aluno_update'] = aluno_update!.toJson();
    }
    return json;
  }

  const AdminUpdateStudentData({this.aluno_update});
}

@immutable
class AdminUpdateStudentVariables {
  final String id;
  final String nome;
  final int idade;
  final String responsavel;
  final String telefone;
  late final Optional<String> email;
  final int presenca;
  @Deprecated(
    'fromJson is deprecated for Variable classes as they are no longer required for deserialization.',
  )
  AdminUpdateStudentVariables.fromJson(Map<String, dynamic> json)
    : id = nativeFromJson<String>(json['id']),
      nome = nativeFromJson<String>(json['nome']),
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

    final AdminUpdateStudentVariables otherTyped =
        other as AdminUpdateStudentVariables;
    return id == otherTyped.id &&
        nome == otherTyped.nome &&
        idade == otherTyped.idade &&
        responsavel == otherTyped.responsavel &&
        telefone == otherTyped.telefone &&
        email == otherTyped.email &&
        presenca == otherTyped.presenca;
  }

  @override
  int get hashCode => Object.hashAll([
    id.hashCode,
    nome.hashCode,
    idade.hashCode,
    responsavel.hashCode,
    telefone.hashCode,
    email.hashCode,
    presenca.hashCode,
  ]);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
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

  AdminUpdateStudentVariables({
    required this.id,
    required this.nome,
    required this.idade,
    required this.responsavel,
    required this.telefone,
    required this.email,
    required this.presenca,
  });
}
