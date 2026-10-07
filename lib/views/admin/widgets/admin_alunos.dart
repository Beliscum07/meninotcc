import 'package:flutter/material.dart';

import '../../../models/atividade_model.dart';
import '../../../services/aluno_data_service.dart';
import '../../../services/api_service.dart';

class AdminAlunosPage extends StatefulWidget {
  const AdminAlunosPage({super.key});

  @override
  State<AdminAlunosPage> createState() => _AdminAlunosPageState();
}

class _AdminAlunosPageState extends State<AdminAlunosPage> {
  final TextEditingController buscaController = TextEditingController();
  final GmailService gmailService = GmailService();

  final List<String> bolsasDisponiveis = [
    'Bolsa Educação Integral',
    'Bolsa Esporte e Cultura',
    'Bolsa Alimentação',
  ];

  List<String> get atividadesDisponiveis =>
      atividadesMock.map((atividade) => atividade.nome).toList();

  List<Map<String, dynamic>> get alunos => AlunoDataService.instance.alunos;

  String busca = '';

  void _atualizarDados(VoidCallback alteracao) {
    setState(alteracao);
    AlunoDataService.instance.notificarAlteracao();
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
            child: alunosFiltrados.isEmpty
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
          const Divider(height: 24),
          Text(
            'Bolsas (${bolsas.length})',
            style: const TextStyle(
              color: Color(0xFF565A9A),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          if (bolsas.isEmpty)
            const Text(
              'Nenhuma bolsa atribuída',
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
                  ),
                  label: Text(bolsa),
                  onDeleted: () {
                    _atualizarDados(() => bolsas.remove(bolsa));
                  },
                );
              }).toList(),
            ),
          const SizedBox(height: 8),
          if (atividades.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: atividades.map((atividade) {
                return Chip(
                  label: Text(atividade),
                  onDeleted: () {
                    _atualizarDados(() => atividades.remove(atividade));
                  },
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
                      : () {
                          final atividades =
                              aluno['atividades'] as List<String>;
                          if (!atividades.contains(atividadeSelecionada)) {
                            _atualizarDados(() {
                              atividades.add(atividadeSelecionada!);
                            });
                          }
                          Navigator.pop(dialogContext);
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
                      : () {
                          _atualizarDados(() {
                            bolsasDoAluno.add(bolsaSelecionada!);
                          });
                          Navigator.pop(dialogContext);
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
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: idade,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Idade'),
                ),
                TextField(
                  controller: responsavel,
                  decoration: const InputDecoration(labelText: 'Responsável'),
                ),
                TextField(
                  controller: telefone,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                ),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
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
              onPressed: () {
                if (!_emailValido(email.text.trim())) {
                  _mensagem('Informe um e-mail válido para o aluno.');
                  return;
                }
                _atualizarDados(() {
                  alunos.add({
                    'id': _novoIdAluno(),
                    'nome': nome.text.trim(),
                    'idade': int.tryParse(idade.text) ?? 0,
                    'responsavel': responsavel.text.trim(),
                    'telefone': telefone.text.trim(),
                    'email': email.text.trim().toLowerCase(),
                    'presenca': 100,
                    'atividades': <String>[],
                    'bolsas': <String>[],
                  });
                });
                Navigator.pop(dialogContext);
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

  String _novoIdAluno() {
    final maiorId = alunos
        .map((aluno) => int.tryParse(aluno['id'].toString()) ?? 0)
        .fold<int>(0, (maior, atual) => atual > maior ? atual : maior);
    return (maiorId + 1).toString().padLeft(3, '0');
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
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: idade,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Idade'),
                ),
                TextField(
                  controller: responsavel,
                  decoration: const InputDecoration(labelText: 'Responsável'),
                ),
                TextField(
                  controller: telefone,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                ),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
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
              onPressed: () {
                if (!_emailValido(email.text.trim())) {
                  _mensagem('Informe um e-mail válido para o aluno.');
                  return;
                }
                _atualizarDados(() {
                  aluno['nome'] = nome.text.trim();
                  aluno['idade'] = int.tryParse(idade.text) ?? 0;
                  aluno['responsavel'] = responsavel.text.trim();
                  aluno['telefone'] = telefone.text.trim();
                  aluno['email'] = email.text.trim().toLowerCase();
                });
                Navigator.pop(dialogContext);
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
              onPressed: () {
                _atualizarDados(() => alunos.remove(aluno));
                Navigator.pop(dialogContext);
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

  bool _emailValido(String valor) =>
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(valor);

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
              if (assunto.text.trim().isEmpty || corpo.text.trim().isEmpty) {
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
