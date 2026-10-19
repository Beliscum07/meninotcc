import '../generated/example.dart';

class SqlConnectService {
  SqlConnectService._();

  static final SqlConnectService instance = SqlConnectService._();

  ExampleConnector get _connector => ExampleConnector.instance;

  Future<GetMyProfileUsuario?> buscarMeuPerfil() async {
    final result = await _connector.getMyProfile().execute();
    return result.data.usuario;
  }

  Future<GetMyStudentAlunos?> buscarMeuPerfilAluno() async {
    final result = await _connector.getMyStudent().execute();
    return result.data.alunos.isEmpty ? null : result.data.alunos.first;
  }

  Future<void> cadastrarPerfilDoador({
    required String nome,
    required String telefone,
  }) async {
    await _connector
        .registerDonorProfile(nome: nome.trim(), telefone: telefone.trim())
        .execute();
  }

  Future<void> atualizarMeuPerfil({
    required String nome,
    required String? telefone,
  }) async {
    await _connector
        .updateMyProfile(nome: nome.trim())
        .telefone(telefone?.trim())
        .execute();
  }

  Future<List<ListStudentsAlunos>> listarAlunos() async {
    final result = await _connector.listStudents().execute();
    return result.data.alunos;
  }

  Future<void> criarAluno({
    required String nome,
    required int idade,
    required String responsavel,
    required String telefone,
    required String? email,
    required int presenca,
  }) async {
    await _connector
        .adminCreateStudent(
          nome: nome,
          idade: idade,
          responsavel: responsavel,
          telefone: telefone,
          presenca: presenca,
        )
        .email(email)
        .execute();
  }

  Future<void> atualizarAluno({
    required String id,
    required String nome,
    required int idade,
    required String responsavel,
    required String telefone,
    required String? email,
    required int presenca,
  }) async {
    await _connector
        .adminUpdateStudent(
          id: id,
          nome: nome,
          idade: idade,
          responsavel: responsavel,
          telefone: telefone,
          presenca: presenca,
        )
        .email(email)
        .execute();
  }

  Future<void> alterarStatusAluno({
    required String id,
    required String status,
  }) async {
    await _connector.adminSetStudentStatus(id: id, status: status).execute();
  }

  Future<void> vincularContaAluno({
    required String studentId,
    required String authUid,
    required String authEmail,
  }) async {
    await _connector
        .adminLinkStudentAccount(
          studentId: studentId,
          authUid: authUid.trim(),
          authEmail: authEmail.trim(),
        )
        .execute();
  }

  Future<List<ListActivitiesAtividades>> listarAtividades() async {
    final result = await _connector.listActivities().execute();
    return result.data.atividades;
  }

  Future<void> criarAtividade({
    required String nome,
    required String professor,
    required String descricao,
    required String horario,
    required String dias,
    required int vagas,
    required String categoria,
  }) async {
    await _connector
        .adminCreateActivity(nome: nome, professor: professor, vagas: vagas)
        .descricao(descricao)
        .horario(horario)
        .dias(dias)
        .categoria(categoria)
        .execute();
  }

  Future<void> atualizarAtividade({
    required String id,
    required String nome,
    required String professor,
    required String descricao,
    required String horario,
    required String dias,
    required int vagas,
    required String categoria,
    required String status,
  }) async {
    await _connector
        .adminUpdateActivity(
          id: id,
          nome: nome,
          professor: professor,
          vagas: vagas,
          status: status,
        )
        .descricao(descricao)
        .horario(horario)
        .dias(dias)
        .categoria(categoria)
        .execute();
  }

  Future<void> atribuirAtividade({
    required String alunoId,
    required String atividadeId,
  }) async {
    await _connector
        .adminAssignActivity(alunoId: alunoId, atividadeId: atividadeId)
        .execute();
  }

  Future<List<ListScholarshipsBolsas>> listarBolsas() async {
    final result = await _connector.listScholarships().execute();
    return result.data.bolsas;
  }

  Future<void> criarBolsa({
    required String nome,
    required String descricao,
    required double valorMensal,
  }) async {
    await _connector
        .adminCreateScholarship(nome: nome, valorMensal: valorMensal)
        .descricao(descricao)
        .execute();
  }

  Future<void> atualizarBolsa({
    required String id,
    required String nome,
    required String descricao,
    required double valorMensal,
    required bool ativa,
  }) async {
    await _connector
        .adminUpdateScholarship(
          id: id,
          nome: nome,
          valorMensal: valorMensal,
          ativa: ativa,
        )
        .descricao(descricao)
        .execute();
  }

  Future<void> atribuirBolsa({
    required String alunoId,
    required String bolsaId,
    required double valorConcedido,
  }) async {
    await _connector
        .adminAssignScholarship(
          alunoId: alunoId,
          bolsaId: bolsaId,
          valorConcedido: valorConcedido,
        )
        .execute();
  }

  Future<List<ListAgendaAgendas>> listarAgenda() async {
    final result = await _connector.listAgenda().execute();
    return result.data.agendas;
  }

  Future<List<GetMyNotificationsNotificacoes>> minhasNotificacoes() async {
    final result = await _connector.getMyNotifications().execute();
    return result.data.notificacoes;
  }

  Future<void> marcarNotificacaoComoLida(String id) async {
    await _connector.markMyNotificationRead(id: id).execute();
  }

  Future<List<ListMyDonationsDoacoes>> minhasDoacoes() async {
    final result = await _connector.listMyDonations().execute();
    return result.data.doacoes;
  }

  Future<void> registrarDoacao({
    required double valor,
    required String metodo,
  }) async {
    await _connector.registerMyDonation(valor: valor).metodo(metodo).execute();
  }

  Future<List<ListDonationsDoacoes>> listarDoacoes() async {
    final result = await _connector.listDonations().execute();
    return result.data.doacoes;
  }

  Future<void> alterarStatusDoacao({
    required String id,
    required String status,
  }) async {
    await _connector.adminSetDonationStatus(id: id, status: status).execute();
  }
}
