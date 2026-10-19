part of 'example.dart';

class GetMyStudentVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetMyStudentVariablesBuilder(this._dataConnect, );
  Deserializer<GetMyStudentData> dataDeserializer = (dynamic json)  => GetMyStudentData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetMyStudentData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetMyStudentData, void> ref() {
    
    return _dataConnect.query("GetMyStudent", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetMyStudentAlunos {
  final String id;
  final String nome;
  final int idade;
  final String responsavel;
  final String telefone;
  final String? email;
  final int presenca;
  final List<GetMyStudentAlunosInscricoesOnAluno> inscricoes_on_aluno;
  final List<GetMyStudentAlunosAlunoBolsasOnAluno> alunoBolsas_on_aluno;
  GetMyStudentAlunos.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  idade = nativeFromJson<int>(json['idade']),
  responsavel = nativeFromJson<String>(json['responsavel']),
  telefone = nativeFromJson<String>(json['telefone']),
  email = json['email'] == null ? null : nativeFromJson<String>(json['email']),
  presenca = nativeFromJson<int>(json['presenca']),
  inscricoes_on_aluno = (json['inscricoes_on_aluno'] as List<dynamic>)
        .map((e) => GetMyStudentAlunosInscricoesOnAluno.fromJson(e))
        .toList(),
  alunoBolsas_on_aluno = (json['alunoBolsas_on_aluno'] as List<dynamic>)
        .map((e) => GetMyStudentAlunosAlunoBolsasOnAluno.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyStudentAlunos otherTyped = other as GetMyStudentAlunos;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    idade == otherTyped.idade && 
    responsavel == otherTyped.responsavel && 
    telefone == otherTyped.telefone && 
    email == otherTyped.email && 
    presenca == otherTyped.presenca && 
    inscricoes_on_aluno == otherTyped.inscricoes_on_aluno && 
    alunoBolsas_on_aluno == otherTyped.alunoBolsas_on_aluno;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, idade.hashCode, responsavel.hashCode, telefone.hashCode, email.hashCode, presenca.hashCode, inscricoes_on_aluno.hashCode, alunoBolsas_on_aluno.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    json['idade'] = nativeToJson<int>(idade);
    json['responsavel'] = nativeToJson<String>(responsavel);
    json['telefone'] = nativeToJson<String>(telefone);
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    json['presenca'] = nativeToJson<int>(presenca);
    json['inscricoes_on_aluno'] = inscricoes_on_aluno.map((e) => e.toJson()).toList();
    json['alunoBolsas_on_aluno'] = alunoBolsas_on_aluno.map((e) => e.toJson()).toList();
    return json;
  }

  GetMyStudentAlunos({
    required this.id,
    required this.nome,
    required this.idade,
    required this.responsavel,
    required this.telefone,
    this.email,
    required this.presenca,
    required this.inscricoes_on_aluno,
    required this.alunoBolsas_on_aluno,
  });
}

@immutable
class GetMyStudentAlunosInscricoesOnAluno {
  final GetMyStudentAlunosInscricoesOnAlunoAtividade atividade;
  GetMyStudentAlunosInscricoesOnAluno.fromJson(dynamic json):
  
  atividade = GetMyStudentAlunosInscricoesOnAlunoAtividade.fromJson(json['atividade']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyStudentAlunosInscricoesOnAluno otherTyped = other as GetMyStudentAlunosInscricoesOnAluno;
    return atividade == otherTyped.atividade;
    
  }
  @override
  int get hashCode => atividade.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['atividade'] = atividade.toJson();
    return json;
  }

  GetMyStudentAlunosInscricoesOnAluno({
    required this.atividade,
  });
}

@immutable
class GetMyStudentAlunosInscricoesOnAlunoAtividade {
  final String id;
  final String nome;
  final String professor;
  final String? descricao;
  final String? horario;
  final String? dias;
  final int vagas;
  GetMyStudentAlunosInscricoesOnAlunoAtividade.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  professor = nativeFromJson<String>(json['professor']),
  descricao = json['descricao'] == null ? null : nativeFromJson<String>(json['descricao']),
  horario = json['horario'] == null ? null : nativeFromJson<String>(json['horario']),
  dias = json['dias'] == null ? null : nativeFromJson<String>(json['dias']),
  vagas = nativeFromJson<int>(json['vagas']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyStudentAlunosInscricoesOnAlunoAtividade otherTyped = other as GetMyStudentAlunosInscricoesOnAlunoAtividade;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    professor == otherTyped.professor && 
    descricao == otherTyped.descricao && 
    horario == otherTyped.horario && 
    dias == otherTyped.dias && 
    vagas == otherTyped.vagas;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, professor.hashCode, descricao.hashCode, horario.hashCode, dias.hashCode, vagas.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['nome'] = nativeToJson<String>(nome);
    json['professor'] = nativeToJson<String>(professor);
    if (descricao != null) {
      json['descricao'] = nativeToJson<String?>(descricao);
    }
    if (horario != null) {
      json['horario'] = nativeToJson<String?>(horario);
    }
    if (dias != null) {
      json['dias'] = nativeToJson<String?>(dias);
    }
    json['vagas'] = nativeToJson<int>(vagas);
    return json;
  }

  GetMyStudentAlunosInscricoesOnAlunoAtividade({
    required this.id,
    required this.nome,
    required this.professor,
    this.descricao,
    this.horario,
    this.dias,
    required this.vagas,
  });
}

@immutable
class GetMyStudentAlunosAlunoBolsasOnAluno {
  final GetMyStudentAlunosAlunoBolsasOnAlunoBolsa bolsa;
  GetMyStudentAlunosAlunoBolsasOnAluno.fromJson(dynamic json):
  
  bolsa = GetMyStudentAlunosAlunoBolsasOnAlunoBolsa.fromJson(json['bolsa']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyStudentAlunosAlunoBolsasOnAluno otherTyped = other as GetMyStudentAlunosAlunoBolsasOnAluno;
    return bolsa == otherTyped.bolsa;
    
  }
  @override
  int get hashCode => bolsa.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['bolsa'] = bolsa.toJson();
    return json;
  }

  GetMyStudentAlunosAlunoBolsasOnAluno({
    required this.bolsa,
  });
}

@immutable
class GetMyStudentAlunosAlunoBolsasOnAlunoBolsa {
  final String id;
  final String nome;
  final String? descricao;
  final double valorMensal;
  GetMyStudentAlunosAlunoBolsasOnAlunoBolsa.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  nome = nativeFromJson<String>(json['nome']),
  descricao = json['descricao'] == null ? null : nativeFromJson<String>(json['descricao']),
  valorMensal = nativeFromJson<double>(json['valorMensal']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyStudentAlunosAlunoBolsasOnAlunoBolsa otherTyped = other as GetMyStudentAlunosAlunoBolsasOnAlunoBolsa;
    return id == otherTyped.id && 
    nome == otherTyped.nome && 
    descricao == otherTyped.descricao && 
    valorMensal == otherTyped.valorMensal;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, nome.hashCode, descricao.hashCode, valorMensal.hashCode]);
  

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

  GetMyStudentAlunosAlunoBolsasOnAlunoBolsa({
    required this.id,
    required this.nome,
    this.descricao,
    required this.valorMensal,
  });
}

@immutable
class GetMyStudentData {
  final List<GetMyStudentAlunos> alunos;
  GetMyStudentData.fromJson(dynamic json):
  
  alunos = (json['alunos'] as List<dynamic>)
        .map((e) => GetMyStudentAlunos.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyStudentData otherTyped = other as GetMyStudentData;
    return alunos == otherTyped.alunos;
    
  }
  @override
  int get hashCode => alunos.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['alunos'] = alunos.map((e) => e.toJson()).toList();
    return json;
  }

  GetMyStudentData({
    required this.alunos,
  });
}

