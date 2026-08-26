import 'package:flutter/material.dart';

class AdminAlunos extends StatefulWidget {
  const AdminAlunos({super.key});

  @override
  State<AdminAlunos> createState() => _AdminAlunosState();
}

class _AdminAlunosState extends State<AdminAlunos> {
  // TextEditingController serve para capturar o texto digitado pelo usuário.
  // É como uma "caixa de texto" que guarda o valor atual do input.
  final TextEditingController _searchController = TextEditingController();

  // Lista de alunos com dados simulados para visualizar no painel administrativo.
  // A palavra-chave final indica que a lista não será trocada inteira,
  // mas os objetos dentro dela podem ser alterados se o campo não for final.
  final List<_AlunoPerfil> _alunos = [
    _AlunoPerfil(
      nome: 'Ana Clara',
      curso: 'Desenvolvimento de Sistemas',
      turno: 'Manhã',
      status: 'Ativa',
      responsavel: 'Maria da Silva',
      porcentagemPresenca: 96,
      atividades: {
        'Coral': 85,
        'Arte': 70,
        'Dança': 60,
        'Esporte': 90,
      },
      resumo:
          'Aluna muito dedicada, participa com frequência das atividades e demonstra boa disciplina e comprometimento.',
      avatar: 'AC',
      cor: const Color(0xFF7C3AED),
    ),
    _AlunoPerfil(
      nome: 'João Pedro',
      curso: 'Administração',
      turno: 'Tarde',
      status: 'Em acompanhamento',
      responsavel: 'Carlos Mendes',
      porcentagemPresenca: 88,
      atividades: {
        'Coral': 50,
        'Arte': 60,
        'Dança': 75,
        'Esporte': 80,
      },
      resumo:
          'Aluno com bom relacionamento em equipe, mas precisa melhorar a presença em algumas atividades complementares.',
      avatar: 'JP',
      cor: const Color(0xFF0EA5E9),
    ),
    _AlunoPerfil(
      nome: 'Maria Luiza',
      curso: 'Recursos Humanos',
      turno: 'Noite',
      status: 'Ativa',
      responsavel: 'Sônia Almeida',
      porcentagemPresenca: 94,
      atividades: {
        'Coral': 90,
        'Arte': 80,
        'Dança': 70,
        'Esporte': 65,
      },
      resumo:
          'Excelente comunicação, participa das atividades da instituição e tem bom engajamento em projetos sociais.',
      avatar: 'ML',
      cor: const Color(0xFF10B981),
    ),
    _AlunoPerfil(
      nome: 'Lucas Paulo',
      curso: 'Design Gráfico',
      turno: 'Manhã',
      status: 'Ativo',
      responsavel: 'Patrícia Lima',
      porcentagemPresenca: 91,
      atividades: {
        'Coral': 40,
        'Arte': 95,
        'Dança': 55,
        'Esporte': 70,
      },
      resumo:
          'Criativo e motivado, com forte desempenho em atividades artísticas e visualmente expressivas.',
      avatar: 'LP',
      cor: const Color(0xFFF59E0B),
    ),
    _AlunoPerfil(
      nome: 'Beatriz Souza',
      curso: 'Enfermagem',
      turno: 'Noite',
      status: 'Ativa',
      responsavel: 'José Souza',
      porcentagemPresenca: 98,
      atividades: {
        'Coral': 80,
        'Arte': 65,
        'Dança': 85,
        'Esporte': 75,
      },
      resumo:
          'Responsável, organizada e sempre presente. Gosta de participar de atividades coletivas e comunitárias.',
      avatar: 'BS',
      cor: const Color(0xFFEC4899),
    ),
  ];

  @override
  void dispose() {
    // dispose() é importante para limpar recursos quando a tela sai da memória.
    // Aqui limpamos o controlador do campo de busca para evitar vazamentos.
    _searchController.dispose();
    super.dispose();
  }

  // Getter que retorna a lista filtrada de acordo com o texto digitado.
  // Ele funciona como uma "filtro automático" da listagem.
  List<_AlunoPerfil> get _alunosFiltrados {
    final termo = _searchController.text.trim().toLowerCase();

    if (termo.isEmpty) {
      return _alunos;
    }

    return _alunos.where((aluno) {
      return aluno.nome.toLowerCase().contains(termo) ||
          aluno.curso.toLowerCase().contains(termo) ||
          aluno.turno.toLowerCase().contains(termo) ||
          aluno.responsavel.toLowerCase().contains(termo);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.sizeOf(context).width;
    final colunas = largura >= 900
        ? 3
        : largura >= 600
            ? 2
            : 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Alunos'),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(largura >= 700 ? 24 : 16),
        child: Column(
          children: [
            // Container cria um bloco visual com bordas e fundo.
            // TextField cria o campo de busca, e o prefixIcon adiciona o ícone.
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                // onChanged é chamado toda vez que o usuário digita algo.
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Pesquisar aluno, curso ou responsável',
                  prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            // clear() apaga o texto do campo e setState() redesenha a tela.
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Expanded ocupa o espaço restante da tela.
            // GridView.builder cria uma grade dinâmica de cards.
            Expanded(
              child: _alunosFiltrados.isEmpty
                  ? const Center(
                      child: Text('Nenhum aluno encontrado.'),
                    )
                  : GridView.builder(
                      itemCount: _alunosFiltrados.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: colunas,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: largura >= 900 ? 1.45 : 1.2,
                      ),
                      itemBuilder: (context, index) {
                        final aluno = _alunosFiltrados[index];

                        return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: aluno.cor,
                                      child: Text(
                                        aluno.avatar,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        aluno.nome,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                _InfoLinha(icon: Icons.school_rounded, text: aluno.curso),
                                const SizedBox(height: 8),
                                _InfoLinha(icon: Icons.schedule_rounded, text: aluno.turno),
                                const SizedBox(height: 8),
                                _InfoLinha(
                                  icon: Icons.person_rounded,
                                  text: 'Responsável: ${aluno.responsavel}',
                                ),
                                const SizedBox(height: 8),
                                _InfoLinha(
                                  icon: Icons.percent_rounded,
                                  text: 'Presença: ${aluno.porcentagemPresenca}',
                                ),
                                const SizedBox(height: 12),

                                // Wrap organiza widgets em linha e quebra quando não cabe.
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: aluno.atividades.entries.map((entrada) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: aluno.cor.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '${entrada.key}: ${entrada.value}%',
                                        style: TextStyle(
                                          color: aluno.cor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),

                                const SizedBox(height: 14),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: aluno.cor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    aluno.status,
                                    style: TextStyle(
                                      color: aluno.cor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Row coloca os botões lado a lado, e Expanded faz cada um ocupar espaço.
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () => _mostrarDetalhes(aluno),
                                        icon: const Icon(Icons.visibility_outlined, size: 18),
                                        label: const Text('Detalhes'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.deepPurple,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () => _editarAluno(aluno),
                                        icon: const Icon(Icons.edit_outlined, size: 18),
                                        label: const Text('Editar'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.deepPurple,
                                          side: const BorderSide(color: Colors.deepPurple),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // showModalBottomSheet abre uma tela inferior com mais detalhes do aluno.
  // Ele é útil para mostrar informações adicionais sem trocar de página.
  Future<void> _mostrarDetalhes(_AlunoPerfil aluno) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            24,
            20,
            MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: aluno.cor,
                    child: Text(
                      aluno.avatar,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  aluno.nome,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _InfoLinha(icon: Icons.school_rounded, text: aluno.curso),
                const SizedBox(height: 8),
                _InfoLinha(icon: Icons.schedule_rounded, text: aluno.turno),
                const SizedBox(height: 8),
                _InfoLinha(icon: Icons.person_rounded, text: 'Responsável: ${aluno.responsavel}'),
                const SizedBox(height: 8),
                _InfoLinha(icon: Icons.percent_rounded, text: 'Presença: ${aluno.porcentagemPresenca}%'),
                const SizedBox(height: 8),
                _InfoLinha(icon: Icons.check_circle_rounded, text: aluno.status),
                const SizedBox(height: 20),

                Text(
                  'Atividades do aluno',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Map.entries percorre cada item do mapa ('Coral', 'Arte', etc.).
                ...aluno.atividades.entries.map((atividade) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(atividade.key),
                            Text('${atividade.value}%'),
                          ],
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: atividade.value / 100,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(8),
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(aluno.cor),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                const SizedBox(height: 20),
                Text(
                  'Resumo do perfil',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  aluno.resumo,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Fechar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Método de edição: abre um diálogo para alterar os dados do aluno.
  // O valor do TextEditingController será preenchido com os dados atuais.
  Future<void> _editarAluno(_AlunoPerfil aluno) async {
    final nomeController = TextEditingController(text: aluno.nome);
    final cursoController = TextEditingController(text: aluno.curso);
    final turnoController = TextEditingController(text: aluno.turno);
    final responsavelController = TextEditingController(text: aluno.responsavel);
    final presencaController = TextEditingController(text: aluno.porcentagemPresenca.toString());
    final coralController = TextEditingController(text: aluno.atividades['Coral']?.toString() ?? '0');
    final arteController = TextEditingController(text: aluno.atividades['Arte']?.toString() ?? '0');
    final dancaController = TextEditingController(text: aluno.atividades['Dança']?.toString() ?? '0');
    final esporteController = TextEditingController(text: aluno.atividades['Esporte']?.toString() ?? '0');

    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar aluno'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: cursoController,
                  decoration: const InputDecoration(labelText: 'Curso'),
                ),
                TextField(
                  controller: turnoController,
                  decoration: const InputDecoration(labelText: 'Turno'),
                ),
                TextField(
                  controller: responsavelController,
                  decoration: const InputDecoration(labelText: 'Responsável'),
                ),
                TextField(
                  controller: presencaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Presença (%)'),
                ),
                const SizedBox(height: 12),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Atividades',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: coralController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Coral (%)'),
                ),
                TextField(
                  controller: arteController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Arte (%)'),
                ),
                TextField(
                  controller: dancaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Dança (%)'),
                ),
                TextField(
                  controller: esporteController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Esporte (%)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (confirmado == true) {
      setState(() {
        // update() atualiza os valores de um Map em Dart.
        aluno.nome = nomeController.text.trim().isNotEmpty ? nomeController.text.trim() : aluno.nome;
        aluno.curso = cursoController.text.trim().isNotEmpty ? cursoController.text.trim() : aluno.curso;
        aluno.turno = turnoController.text.trim().isNotEmpty ? turnoController.text.trim() : aluno.turno;
        aluno.responsavel = responsavelController.text.trim().isNotEmpty ? responsavelController.text.trim() : aluno.responsavel;

        aluno.porcentagemPresenca = int.tryParse(presencaController.text) ?? aluno.porcentagemPresenca;
        aluno.atividades['Coral'] = int.tryParse(coralController.text) ?? aluno.atividades['Coral'] ?? 0;
        aluno.atividades['Arte'] = int.tryParse(arteController.text) ?? aluno.atividades['Arte'] ?? 0;
        aluno.atividades['Dança'] = int.tryParse(dancaController.text) ?? aluno.atividades['Dança'] ?? 0;
        aluno.atividades['Esporte'] = int.tryParse(esporteController.text) ?? aluno.atividades['Esporte'] ?? 0;
      });
    }
  }
}

class _InfoLinha extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoLinha({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class _AlunoPerfil {
  // A classe _AlunoPerfil representa o modelo de dados do aluno.
  // Em Dart, as propriedades são declaradas dentro da classe e depois preenchidas no construtor.
  String nome;
  String curso;
  String turno;
  String status;
  String responsavel;
  int porcentagemPresenca;
  Map<String, int> atividades;
  String resumo;
  String avatar;
  Color cor;

  _AlunoPerfil({
    required this.nome,
    required this.curso,
    required this.turno,
    required this.status,
    required this.responsavel,
    required this.porcentagemPresenca,
    required this.atividades,
    required this.resumo,
    required this.avatar,
    required this.cor,
  });
}

