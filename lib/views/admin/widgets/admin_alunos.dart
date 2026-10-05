import 'package:flutter/material.dart';

class AdminAlunosPage extends StatefulWidget {
  const AdminAlunosPage({super.key});

  @override
  State<AdminAlunosPage> createState() => _AdminAlunosPageState();
}

class _AdminAlunosPageState extends State<AdminAlunosPage> {
  final TextEditingController buscaController =
      TextEditingController();

  // ==============================
  // ALUNOS
  // ==============================

  List<Map<String, dynamic>> alunos = [
    {
      'id': '001',
      'nome': 'João Pedro',
      'idade': 18,
      'responsavel': 'Maria Pedro',
      'telefone': '(16) 99999-1111',
      'presenca': 92,
      'atividades': <String>[],
    },
    {
      'id': '002',
      'nome': 'Lucas Silva',
      'idade': 15,
      'responsavel': 'Ana Silva',
      'telefone': '(16) 99999-2222',
      'presenca': 88,
      'atividades': <String>[],
    },
    {
      'id': '003',
      'nome': 'Mariana Souza',
      'idade': 16,
      'responsavel': 'Carlos Souza',
      'telefone': '(16) 99999-3333',
      'presenca': 95,
      'atividades': <String>[],
    },
  ];

  // ==============================
  // ATIVIDADES DISPONÍVEIS
  // ==============================

  final List<String> atividadesDisponiveis = [
    'Música e Coral',
    'Arte e Pintura',
    'Dança e Movimento',
    'Esportes e Jogos',
  ];

  String busca = '';

  @override
  void dispose() {
    buscaController.dispose();
    super.dispose();
  }

  // ==============================
  // BUILD
  // ==============================

  @override
  Widget build(BuildContext context) {
    final alunosFiltrados = alunos.where((aluno) {
      final nome =
          aluno['nome'].toString().toLowerCase();

      return nome.contains(
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
                    itemBuilder: (context, index) {
                      final aluno =
                          alunosFiltrados[index];

                      return _buildAlunoCard(aluno);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // CABEÇALHO
  // ==============================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
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
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // BUSCA
  // ==============================

  Widget _buildBusca() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: buscaController,
        onChanged: (valor) {
          setState(() {
            busca = valor;
          });
        },
        decoration: InputDecoration(
          hintText: 'Buscar aluno...',
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF565A9A),
          ),
          suffixIcon: busca.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    buscaController.clear();

                    setState(() {
                      busca = '';
                    });
                  },
                  icon: const Icon(Icons.close),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  // ==============================
  // CARD ALUNO
  // ==============================

  Widget _buildAlunoCard(
    Map<String, dynamic> aluno,
  ) {
    final atividades =
        aluno['atividades'] as List<String>;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFD9D9E5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFD778E8),
                      Color(0xFF5551AA),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  aluno['nome'][0],
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      aluno['nome'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '${aluno['idade']} anos • ID: ${aluno['id']}',
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      '${atividades.length} atividades',
                      style: const TextStyle(
                        color: Color(0xFF565A9A),
                      ),
                    ),
                  ],
                ),
              ),

              // BOTÃO +
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFC56BE0),
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    _delegarAluno(aluno);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  tooltip: 'Delegar atividade',
                ),
              ),
            ],
          ),

          const Divider(height: 28),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: atividades.map((atividade) {
              return Chip(
                label: Text(atividade),
                deleteIcon:
                    const Icon(Icons.close),
                onDeleted: () {
                  setState(() {
                    atividades.remove(atividade);
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _editarAluno(aluno);
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                  ),
                  label: const Text('Editar'),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _removerAluno(aluno);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Remover',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==============================
  // DELEGAR ALUNO
  // ==============================

  void _delegarAluno(
    Map<String, dynamic> aluno,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        String? atividadeSelecionada;

        return StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            return AlertDialog(
              title: Text(
                'Delegar ${aluno['nome']}',
              ),

              content: DropdownButtonFormField<String>(
                initialValue: atividadeSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Atividade',
                  border: OutlineInputBorder(),
                ),
                items:
                    atividadesDisponiveis
                        .map(
                          (atividade) =>
                              DropdownMenuItem(
                            value: atividade,
                            child:
                                Text(atividade),
                          ),
                        )
                        .toList(),
                onChanged: (valor) {
                  setDialogState(() {
                    atividadeSelecionada =
                        valor;
                  });
                },
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),

                ElevatedButton(
                  onPressed:
                      atividadeSelecionada ==
                              null
                          ? null
                          : () {
                              setState(() {
                                final lista =
                                    aluno['atividades']
                                        as List<String>;

                                if (!lista.contains(
                                  atividadeSelecionada,
                                )) {
                                  lista.add(
                                    atividadeSelecionada!,
                                  );
                                }
                              });

                              Navigator.pop(context);

                              ScaffoldMessenger.of(
                                this.context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${aluno['nome']} foi delegado para $atividadeSelecionada',
                                  ),
                                ),
                              );
                            },
                  child: const Text(
                    'Delegar',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ==============================
  // ADICIONAR ALUNO
  // ==============================

  void _adicionarAluno() {
    final nome = TextEditingController();
    final idade = TextEditingController();
    final responsavel =
        TextEditingController();
    final telefone = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Adicionar aluno',
          ),

          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nome,
                  decoration:
                      const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),

                TextField(
                  controller: idade,
                  keyboardType:
                      TextInputType.number,
                  decoration:
                      const InputDecoration(
                    labelText: 'Idade',
                  ),
                ),

                TextField(
                  controller: responsavel,
                  decoration:
                      const InputDecoration(
                    labelText: 'Responsável',
                  ),
                ),

                TextField(
                  controller: telefone,
                  decoration:
                      const InputDecoration(
                    labelText: 'Telefone',
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text(
                'Cancelar',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  alunos.add({
                    'id':
                        '${alunos.length + 1}'
                            .padLeft(3, '0'),
                    'nome': nome.text,
                    'idade':
                        int.tryParse(
                              idade.text,
                            ) ??
                            0,
                    'responsavel':
                        responsavel.text,
                    'telefone':
                        telefone.text,
                    'presenca': 100,
                    'atividades':
                        <String>[],
                  });
                });

                Navigator.pop(context);
              },
              child: const Text(
                'Adicionar',
              ),
            ),
          ],
        );
      },
    );
  }

  // ==============================
  // EDITAR ALUNO
  // ==============================

  void _editarAluno(
    Map<String, dynamic> aluno,
  ) {
    final nome =
        TextEditingController(
      text: aluno['nome'],
    );

    final idade =
        TextEditingController(
      text: aluno['idade'].toString(),
    );

    final responsavel =
        TextEditingController(
      text: aluno['responsavel'],
    );

    final telefone =
        TextEditingController(
      text: aluno['telefone'],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Editar aluno',
          ),

          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nome,
                  decoration:
                      const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),

                TextField(
                  controller: idade,
                  keyboardType:
                      TextInputType.number,
                  decoration:
                      const InputDecoration(
                    labelText: 'Idade',
                  ),
                ),

                TextField(
                  controller: responsavel,
                  decoration:
                      const InputDecoration(
                    labelText: 'Responsável',
                  ),
                ),

                TextField(
                  controller: telefone,
                  decoration:
                      const InputDecoration(
                    labelText: 'Telefone',
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text(
                'Cancelar',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  aluno['nome'] = nome.text;
                  aluno['idade'] =
                      int.tryParse(
                            idade.text,
                          ) ??
                          0;
                  aluno['responsavel'] =
                      responsavel.text;
                  aluno['telefone'] =
                      telefone.text;
                });

                Navigator.pop(context);
              },
              child: const Text(
                'Salvar',
              ),
            ),
          ],
        );
      },
    );
  }

  // ==============================
  // REMOVER ALUNO
  // ==============================

  void _removerAluno(
    Map<String, dynamic> aluno,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Remover aluno?',
          ),

          content: Text(
            'Deseja realmente remover ${aluno['nome']}?',
          ),

          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text(
                'Cancelar',
              ),
            ),

            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  alunos.remove(aluno);
                });

                Navigator.pop(context);
              },
              child: const Text(
                'Remover',
                style: TextStyle(
                  color: Colors.white,
                ),
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
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}