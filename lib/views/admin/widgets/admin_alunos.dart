import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/atividade_model.dart';
import '../../../generated/example.dart';
import '../../../services/aluno_data_service.dart';
import '../../../services/api_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/sql_connect_service.dart';

class AdminAlunosPage extends StatefulWidget {
  const AdminAlunosPage({super.key});

  @override
  State<AdminAlunosPage> createState() => _AdminAlunosPageState();
}

class _AdminAlunosPageState extends State<AdminAlunosPage> {
  final TextEditingController buscaController = TextEditingController();
  final GmailService gmailService = GmailService();

  final List<Atividade> _atividades = [];
  final List<ListScholarshipsBolsas> _bolsas = [];
  bool _carregando = true;
  Object? _erro;

  List<Atividade> get atividades =>
      _atividades.where((atividade) => atividade.status == 'ativa').toList();

  List<String> get atividadesDisponiveis =>
      atividades.map((atividade) => atividade.nome).toList();

  List<String> get bolsasDisponiveis =>
      _bolsas.map((bolsa) => bolsa.nome).toList();

  List<Map<String, dynamic>> get alunos => AlunoDataService.instance.alunos;

  String busca = '';

  @override
  void initState() {
    super.initState();
    unawaited(_carregarDados());
  }

  Future<void> _carregarDados() async {
    try {
      await Future.wait([
        AlunoDataService.instance.carregarAlunosAdministrativos(),
        _carregarAtividades(),
        _carregarBolsas(),
      ]);
      if (mounted) {
        setState(() {
          _erro = null;
          _carregando = false;
        });
      }
    } catch (error, stackTrace) {
      debugPrint('Falha ao carregar dados administrativos de alunos: $error');
      debugPrint(stackTrace.toString());
      if (mounted) {
        setState(() {
          _erro = error;
          _carregando = false;
        });
      }
    }
  }

  Future<void> _carregarAtividades() async {
    final registros = await SqlConnectService.instance.listarAtividades();
    _atividades
      ..clear()
      ..addAll(
        registros.map(
          (registro) => Atividade(
            id: registro.id,
            nome: registro.nome,
            professor: registro.professor,
            descricao: registro.descricao ?? '',
            horario: registro.horario ?? '',
            dias: registro.dias ?? '',
            inscritos: registro.inscricoes_on_atividade.length,
            vagas: registro.vagas,
            categoria: registro.categoria ?? 'Geral',
            status: registro.status,
          ),
        ),
      );
  }

  Future<void> _carregarBolsas() async {
    final registros = await SqlConnectService.instance.listarBolsas();
    _bolsas
      ..clear()
      ..addAll(registros.where((bolsa) => bolsa.ativa));
  }

  @override
  void dispose() {
    buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alunosFiltrados = alunos.where((aluno) {
      return aluno['nome'].toString().toLowerCase().contains(
        busca.toLowerCase(),
      );
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          _buildBusca(),
          Expanded(
            child: _carregando
                ? const Center(child: CircularProgressIndicator())
                : _erro != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Não foi possível carregar os dados dos alunos.',
                        ),
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: () {
                            setState(() => _carregando = true);
                            unawaited(_carregarDados());
                          },
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  )
                : alunosFiltrados.isEmpty
                ? _buildSemResultados()
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: alunosFiltrados.length,
                    itemBuilder: (context, index) =>
                        _buildAlunoCard(alunosFiltrados[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: const Color(0xFF565A9A),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Alunos / Inscritos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: _adicionarAluno,
            tooltip: 'Adicionar aluno',
            icon: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildBusca() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: buscaController,
        maxLength: 100,
        onChanged: (valor) => setState(() => busca = valor),
        decoration: InputDecoration(
          hintText: 'Buscar aluno...',
          prefixIcon: const Icon(Icons.search, color: Color(0xFF565A9A)),
          suffixIcon: busca.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    buscaController.clear();
                    setState(() => busca = '');
                  },
                  icon: const Icon(Icons.close),
                ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  Widget _buildAlunoCard(Map<String, dynamic> aluno) {
    final atividades = aluno['atividades'] as List<String>;
    final bolsas = aluno['bolsas'] as List<String>;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFD9D9E5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFD778E8), Color(0xFF5551AA)],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  aluno['nome'].toString().isEmpty
                      ? '?'
                      : aluno['nome'].toString()[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aluno['nome'].toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${aluno['idade']} anos • ID: ${aluno['id']}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${atividades.length} atividades',
                      style: const TextStyle(color: Color(0xFF565A9A)),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _delegarAluno(aluno),
                    tooltip: 'Adicionar atividade',
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xFFC56BE0),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _atribuirBolsa(aluno),
                    tooltip: 'Adicionar bolsa',
                    icon: const Icon(
                      Icons.workspace_premium_outlined,
                      color: Color(0xFF565A9A),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 28),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFFC56BE0),
              ),
              const SizedBox(width: 8),
              Text(
                'Atividades (${atividades.length})',
                style: const TextStyle(
                  color: Color(0xFFC56BE0),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (atividades.isEmpty)
            const Text(
              'Nenhuma atividade atribuída.',
              style: TextStyle(color: Colors.black54),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: atividades.map((atividade) {
                return Chip(
                  avatar: const Icon(
                    Icons.directions_run,
                    size: 18,
                    color: Color(0xFFC56BE0),
                  ),
                  label: Text(atividade),
                );
              }).toList(),
            ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.workspace_premium_outlined,
                color: Color(0xFF565A9A),
              ),
              const SizedBox(width: 8),
              Text(
                'Bolsas (${bolsas.length})',
                style: const TextStyle(
                  color: Color(0xFF565A9A),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (bolsas.isEmpty)
            const Text(
              'Nenhuma bolsa atribuída.',
              style: TextStyle(color: Colors.black54),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: bolsas.map((bolsa) {
                return Chip(
                  avatar: const Icon(
                    Icons.workspace_premium_outlined,
                    size: 18,
                    color: Color(0xFF565A9A),
                  ),
                  label: Text(bolsa),
                );
              }).toList(),
            ),
          const Divider(height: 24),
          Text(
            'Responsável: ${aluno['responsavel']}\n${aluno['telefone']}',
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            'E-mail: ${aluno['email'] ?? 'Não cadastrado'}',
            style: const TextStyle(fontSize: 13),
          ),
          if (aluno['usuarioUid'] == null &&
              (aluno['email'] as String).isNotEmpty) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _vincularContaAluno(aluno),
                icon: const Icon(Icons.link),
                label: const Text('Vincular conta Firebase'),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _editarAluno(aluno),
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Editar'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _removerAluno(aluno),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  label: const Text(
                    'Remover',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _enviarMensagem(aluno),
              icon: const Icon(Icons.mail_outline),
              label: const Text('Enviar mensagem ao aluno'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _vincularContaAluno(Map<String, dynamic> aluno) async {
    final uidController = TextEditingController();
    final uid = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Vincular conta de ${aluno['nome']}'),
        content: TextField(
          controller: uidController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'UID do Firebase Authentication',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(dialogContext, uidController.text.trim()),
            child: const Text('Vincular'),
          ),
        ],
      ),
    );
    uidController.dispose();
    if (uid == null || uid.isEmpty) return;

    try {
      await SqlConnectService.instance.vincularContaAluno(
        studentId: aluno['id'] as String,
        authUid: uid,
        authEmail: aluno['email'] as String,
      );
      await _carregarDados();
      if (mounted) _mensagem('Conta vinculada ao cadastro do aluno.');
    } catch (error, stackTrace) {
      debugPrint('Erro ao vincular conta do aluno: $error\n$stackTrace');
      if (mounted) {
        _mensagem('Não foi possível vincular a conta do aluno.');
      }
    }
  }

  void _delegarAluno(Map<String, dynamic> aluno) {
    String? atividadeSelecionada;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Adicionar atividade para ${aluno['nome']}'),
              content: DropdownButtonFormField<String>(
                initialValue: atividadeSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Atividade',
                  border: OutlineInputBorder(),
                ),
                items: atividadesDisponiveis.map((atividade) {
                  return DropdownMenuItem<String>(
                    value: atividade,
                    child: Text(atividade),
                  );
                }).toList(),
                onChanged: (valor) {
                  setDialogState(() => atividadeSelecionada = valor);
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: atividadeSelecionada == null
                      ? null
                      : () async {
                          final atividade = _atividades.firstWhere(
                            (item) => item.nome == atividadeSelecionada,
                          );
                          try {
                            await SqlConnectService.instance.atribuirAtividade(
                              alunoId: aluno['id'].toString(),
                              atividadeId: atividade.id,
                            );
                            await _carregarDados();
                            if (dialogContext.mounted) {
                              Navigator.pop(dialogContext);
                            }
                          } catch (error, stackTrace) {
                            debugPrint('Falha ao inscrever aluno: $error');
                            debugPrint(stackTrace.toString());
                            _mensagem(AuthService.mensagemErro(error));
                          }
                        },
                  child: const Text('Adicionar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _atribuirBolsa(Map<String, dynamic> aluno) {
    final bolsasDoAluno = aluno['bolsas'] as List<String>;
    final bolsasParaAtribuir = bolsasDisponiveis
        .where((bolsa) => !bolsasDoAluno.contains(bolsa))
        .toList();
    String? bolsaSelecionada;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Atribuir bolsa para ${aluno['nome']}'),
              content: bolsasParaAtribuir.isEmpty
                  ? const Text(
                      'Todas as bolsas disponíveis já foram atribuídas.',
                    )
                  : DropdownButtonFormField<String>(
                      initialValue: bolsaSelecionada,
                      decoration: const InputDecoration(
                        labelText: 'Bolsa',
                        prefixIcon: Icon(Icons.workspace_premium_outlined),
                        border: OutlineInputBorder(),
                      ),
                      items: bolsasParaAtribuir.map((bolsa) {
                        return DropdownMenuItem<String>(
                          value: bolsa,
                          child: Text(bolsa),
                        );
                      }).toList(),
                      onChanged: (valor) {
                        setDialogState(() => bolsaSelecionada = valor);
                      },
                    ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: bolsaSelecionada == null
                      ? null
                      : () async {
                          final bolsa = _bolsas.firstWhere(
                            (item) => item.nome == bolsaSelecionada,
                          );
                          try {
                            await SqlConnectService.instance.atribuirBolsa(
                              alunoId: aluno['id'].toString(),
                              bolsaId: bolsa.id,
                              valorConcedido: bolsa.valorMensal,
                            );
                            await _carregarDados();
                            if (dialogContext.mounted) {
                              Navigator.pop(dialogContext);
                            }
                          } catch (error, stackTrace) {
                            debugPrint('Falha ao atribuir bolsa: $error');
                            debugPrint(stackTrace.toString());
                            _mensagem(AuthService.mensagemErro(error));
                          }
                        },
                  child: const Text('Atribuir'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _adicionarAluno() {
    final nome = TextEditingController();
    final idade = TextEditingController();
    final responsavel = TextEditingController();
    final telefone = TextEditingController();
    final email = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Adicionar aluno'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nome,
                  maxLength: 80,
                  decoration: const InputDecoration(
                    labelText: 'Nome do aluno',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                ),
                TextField(
                  controller: idade,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: 'Idade'),
                ),
                TextField(
                  controller: responsavel,
                  maxLength: 100,
                  decoration: const InputDecoration(labelText: 'Responsável'),
                ),
                TextField(
                  controller: telefone,
                  maxLength: 15,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+() -]')),
                  ],
                  decoration: const InputDecoration(labelText: 'Telefone'),
                ),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 254,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final erro = _validarDadosAluno(
                  nome: nome.text,
                  idade: idade.text,
                  responsavel: responsavel.text,
                  telefone: telefone.text,
                  email: email.text,
                );
                if (erro != null) {
                  _mensagem(erro);
                  return;
                }
                try {
                  await SqlConnectService.instance.criarAluno(
                    nome: nome.text.trim(),
                    idade: int.parse(idade.text),
                    responsavel: responsavel.text.trim(),
                    telefone: telefone.text.trim(),
                    email: email.text.trim().toLowerCase(),
                    presenca: 0,
                  );
                  await _carregarDados();
                  if (dialogContext.mounted) Navigator.pop(dialogContext);
                } catch (error, stackTrace) {
                  debugPrint('Falha ao cadastrar aluno: $error');
                  debugPrint(stackTrace.toString());
                  _mensagem(AuthService.mensagemErro(error));
                  return;
                }
                nome.dispose();
                idade.dispose();
                responsavel.dispose();
                telefone.dispose();
                email.dispose();
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _editarAluno(Map<String, dynamic> aluno) {
    final nome = TextEditingController(text: aluno['nome'].toString());
    final idade = TextEditingController(text: aluno['idade'].toString());
    final responsavel = TextEditingController(
      text: aluno['responsavel'].toString(),
    );
    final telefone = TextEditingController(text: aluno['telefone'].toString());
    final email = TextEditingController(text: aluno['email']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Editar aluno'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nome,
                  maxLength: 80,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: idade,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: 'Idade'),
                ),
                TextField(
                  controller: responsavel,
                  maxLength: 100,
                  decoration: const InputDecoration(labelText: 'Responsável'),
                ),
                TextField(
                  controller: telefone,
                  maxLength: 15,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+() -]')),
                  ],
                  decoration: const InputDecoration(labelText: 'Telefone'),
                ),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 254,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final erro = _validarDadosAluno(
                  nome: nome.text,
                  idade: idade.text,
                  responsavel: responsavel.text,
                  telefone: telefone.text,
                  email: email.text,
                );
                if (erro != null) {
                  _mensagem(erro);
                  return;
                }
                try {
                  await SqlConnectService.instance.atualizarAluno(
                    id: aluno['id'].toString(),
                    nome: nome.text.trim(),
                    idade: int.parse(idade.text),
                    responsavel: responsavel.text.trim(),
                    telefone: telefone.text.trim(),
                    email: email.text.trim().toLowerCase(),
                    presenca: aluno['presenca'] as int? ?? 0,
                  );
                  await _carregarDados();
                  if (dialogContext.mounted) Navigator.pop(dialogContext);
                } catch (error, stackTrace) {
                  debugPrint('Falha ao atualizar aluno: $error');
                  debugPrint(stackTrace.toString());
                  _mensagem(AuthService.mensagemErro(error));
                  return;
                }
                nome.dispose();
                idade.dispose();
                responsavel.dispose();
                telefone.dispose();
                email.dispose();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _removerAluno(Map<String, dynamic> aluno) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Remover aluno?'),
          content: Text('Deseja realmente remover ${aluno['nome']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                try {
                  await SqlConnectService.instance.alterarStatusAluno(
                    id: aluno['id'].toString(),
                    status: 'inativo',
                  );
                  await _carregarDados();
                  if (dialogContext.mounted) Navigator.pop(dialogContext);
                  _mensagem('Cadastro do aluno arquivado.');
                } catch (error, stackTrace) {
                  debugPrint('Falha ao arquivar aluno: $error');
                  debugPrint(stackTrace.toString());
                  _mensagem(AuthService.mensagemErro(error));
                }
              },
              child: const Text(
                'Remover',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSemResultados() {
    return const Center(
      child: Text(
        'Nenhum aluno encontrado.',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  String? _validarDadosAluno({
    required String nome,
    required String idade,
    required String responsavel,
    required String telefone,
    required String email,
  }) {
    final nomeLimpo = nome.trim();
    final idadeNumerica = int.tryParse(idade);
    final emailLimpo = email.trim();
    final telefoneLimpo = telefone.trim();

    if (nomeLimpo.isEmpty) return 'Informe o nome do aluno.';
    if (nomeLimpo.length > 80) {
      return 'O nome do aluno pode ter no máximo 80 caracteres.';
    }
    if (idadeNumerica == null || idadeNumerica < 0 || idadeNumerica > 999) {
      return 'Informe uma idade válida entre 0 e 999.';
    }
    if (responsavel.trim().length > 100) {
      return 'O nome do responsável pode ter no máximo 100 caracteres.';
    }
    if (telefoneLimpo.length > 15 ||
        !RegExp(r'^[0-9+() -]*$').hasMatch(telefoneLimpo)) {
      return 'Informe um telefone com até 15 caracteres usando apenas números e + ( ) - ou espaços.';
    }
    if (!_emailValido(emailLimpo)) {
      return 'Informe um e-mail válido para o aluno.';
    }
    return null;
  }

  bool _emailValido(String valor) =>
      valor.length <= 254 &&
      RegExp(
        r'^[^@\s.]+(?:\.[^@\s.]+)*@[^@\s.]+(?:\.[^@\s.]+)+$',
      ).hasMatch(valor);

  void _enviarMensagem(Map<String, dynamic> aluno) {
    final destinatario = aluno['email']?.toString().trim() ?? '';
    if (!_emailValido(destinatario)) {
      _mensagem('Este aluno não possui um e-mail válido.');
      return;
    }
    final assunto = TextEditingController();
    final corpo = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Mensagem para ${aluno['nome']}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: assunto,
                maxLength: 100,
                decoration: const InputDecoration(labelText: 'Assunto'),
              ),
              TextField(
                controller: corpo,
                maxLength: 2000,
                maxLines: 6,
                decoration: const InputDecoration(labelText: 'Mensagem'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              if (assunto.text.trim().isEmpty) {
                _mensagem('Informe o assunto da mensagem.');
                return;
              }
              if (corpo.text.trim().isEmpty) {
                _mensagem('Informe o conteúdo da mensagem.');
                return;
              }
              Navigator.pop(dialogContext);
              final enviado = await gmailService.enviarEmail(
                destinatario: destinatario,
                assunto: assunto.text.trim(),
                corpoTexto: corpo.text.trim(),
              );
              if (mounted) {
                _mensagem(
                  enviado
                      ? 'Mensagem enviada para $destinatario.'
                      : 'Não foi possível enviar. Confira o Google Sign-In/API.',
                );
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  void _mensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }
}
