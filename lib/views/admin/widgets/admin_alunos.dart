import 'package:flutter/material.dart';

import 'card_aluno.dart';
import '../../../models/student_model.dart';

class AdminAlunosPage extends StatefulWidget {
  final ValueChanged<Aluno>? onOpenAluno;

  const AdminAlunosPage({
    super.key,
    this.onOpenAluno,
  });

  @override
  State<AdminAlunosPage> createState() => _AdminAlunosPageState();
}

class _AdminAlunosPageState extends State<AdminAlunosPage> {
  String pesquisa = '';

  final List<Aluno> alunos = [
    Aluno(
      nome: 'João Pedro Silva',
      idade: 10,
      id: '001',
      atividades: 2,
      presenca: 92,
      responsavel: 'Maria Silva',
      telefone: '(11) 98765-4321',
      email: 'joao.silva@email.com',
      senha: '123456',
    ),
    Aluno(
      nome: 'Ana Clara Santos',
      idade: 10,
      id: '002',
      atividades: 2,
      presenca: 88,
      responsavel: 'José Santos',
      telefone: '(11) 98765-1234',
      email: 'ana.santos@email.com',
      senha: '123456',
    ),
    Aluno(
      nome: 'Lucas Oliveira',
      idade: 8,
      id: '003',
      atividades: 2,
      presenca: 95,
      responsavel: 'Carla Oliveira',
      telefone: '(11) 98765-5678',
      email: 'lucas.oliveira@email.com',
      senha: '123456',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _cabecalho(),
          Expanded(
            child: _telaAlunos(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CABEÇALHO
  // ============================================================

  Widget _cabecalho() {
    return Container(
      height: 62,
      width: double.infinity,
      color: const Color(0xFF5558AD),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: const Text(
        'Gestão de Alunos',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // TELA DE ALUNOS
  // ============================================================

  Widget _telaAlunos() {
    final listaFiltrada = alunos.where((aluno) {
      return aluno.nome.toLowerCase().contains(
            pesquisa.toLowerCase(),
          );
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            11,
            16,
            11,
            16,
          ),
          child: TextField(
            onChanged: (valor) {
              setState(() {
                pesquisa = valor;
              });
            },
            decoration: InputDecoration(
              hintText: 'Buscar aluno...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            itemCount: listaFiltrada.length,
            itemBuilder: (context, index) {
              final aluno = listaFiltrada[index];

              return CardAluno(
                aluno: aluno,
                onDetalhes: () => _mostrarDetalhes(aluno),
                onEditar: () => _editarAluno(aluno),
              );
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DETALHES DO ALUNO
  // ============================================================

  void _mostrarDetalhes(Aluno aluno) {
    if (widget.onOpenAluno != null) {
      widget.onOpenAluno!(aluno);
    }

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 40,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Cabeçalho
                  Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
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
                          aluno.nome.isNotEmpty
                              ? aluno.nome[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
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
                              aluno.nome,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'ID: ${aluno.id}',
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Divider(),

                  const SizedBox(height: 14),

                  // Informações pessoais
                  const Text(
                    'Informações pessoais',
                    style: TextStyle(
                      color: Color(0xFF5552A6),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _infoDetalhe(
                    Icons.person_outline,
                    'Nome',
                    aluno.nome,
                  ),

                  _infoDetalhe(
                    Icons.cake_outlined,
                    'Idade',
                    '${aluno.idade} anos',
                  ),

                  _infoDetalhe(
                    Icons.badge_outlined,
                    'ID',
                    aluno.id,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Atividades',
                    style: TextStyle(
                      color: Color(0xFF5552A6),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _infoCard(
                          Icons.calendar_today_outlined,
                          'Atividades',
                          '${aluno.atividades}',
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _infoCard(
                          Icons.percent,
                          'Presença',
                          '${aluno.presenca}%',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Responsável',
                    style: TextStyle(
                      color: Color(0xFF5552A6),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _infoDetalhe(
                    Icons.person_outline,
                    'Nome',
                    aluno.responsavel,
                  ),

                  _infoDetalhe(
                    Icons.phone_outlined,
                    'Telefone',
                    aluno.telefone,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Acesso',
                    style: TextStyle(
                      color: Color(0xFF5552A6),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _infoDetalhe(
                    Icons.email_outlined,
                    'E-mail',
                    aluno.email,
                  ),

                  _infoDetalhe(
                    Icons.lock_outline,
                    'Senha',
                    '••••••••',
                  ),

                  const SizedBox(height: 20),

                  // Botão editar
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _editarAluno(aluno);
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Editar informações'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5552A6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
        );
      },
    );
  }

  // ============================================================
  // COMPONENTE DE INFORMAÇÃO
  // ============================================================

  Widget _infoDetalhe(
    IconData icone,
    String titulo,
    String valor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icone,
            size: 20,
            color: const Color(0xFF5552A6),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: '$titulo: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: valor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD DE INFORMAÇÃO
  // ============================================================

  Widget _infoCard(
    IconData icone,
    String titulo,
    String valor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icone,
            size: 20,
            color: const Color(0xFF5552A6),
          ),

          const SizedBox(height: 7),

          Text(
            titulo,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            valor,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EDITAR ALUNO
  // ============================================================

  void _editarAluno(Aluno aluno) {
    final nomeController =
        TextEditingController(text: aluno.nome);

    final idadeController =
        TextEditingController(text: aluno.idade.toString());

    final idController =
        TextEditingController(text: aluno.id);

    final atividadesController =
        TextEditingController(text: aluno.atividades.toString());

    final presencaController =
        TextEditingController(text: aluno.presenca.toString());

    final responsavelController =
        TextEditingController(text: aluno.responsavel);

    final telefoneController =
        TextEditingController(text: aluno.telefone);

    final emailController =
        TextEditingController(text: aluno.email);

    final senhaController =
        TextEditingController(text: aluno.senha);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Editar aluno',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: SizedBox(
            width: 450,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  _campoEditar(
                    controller: nomeController,
                    label: 'Nome',
                    icon: Icons.person_outline,
                  ),

                  _campoEditar(
                    controller: idadeController,
                    label: 'Idade',
                    icon: Icons.cake_outlined,
                    tipo: TextInputType.number,
                  ),

                  _campoEditar(
                    controller: idController,
                    label: 'ID',
                    icon: Icons.badge_outlined,
                  ),

                  _campoEditar(
                    controller: atividadesController,
                    label: 'Atividades',
                    icon: Icons.calendar_today_outlined,
                    tipo: TextInputType.number,
                  ),

                  _campoEditar(
                    controller: presencaController,
                    label: 'Presença (%)',
                    icon: Icons.percent,
                    tipo: TextInputType.number,
                  ),

                  _campoEditar(
                    controller: responsavelController,
                    label: 'Responsável',
                    icon: Icons.supervisor_account_outlined,
                  ),

                  _campoEditar(
                    controller: telefoneController,
                    label: 'Telefone',
                    icon: Icons.phone_outlined,
                    tipo: TextInputType.phone,
                  ),

                  _campoEditar(
                    controller: emailController,
                    label: 'E-mail',
                    icon: Icons.email_outlined,
                    tipo: TextInputType.emailAddress,
                  ),

                  _campoEditar(
                    controller: senhaController,
                    label: 'Senha',
                    icon: Icons.lock_outline,
                    senha: true,
                  ),
                ],
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Color(0xFF5552A6),
                ),
              ),
            ),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF5552A6),
              ),
              onPressed: () {
                setState(() {
                  aluno.nome = nomeController.text;
                  aluno.idade =
                      int.tryParse(idadeController.text) ??
                          aluno.idade;

                  aluno.id = idController.text;

                  aluno.atividades =
                      int.tryParse(
                            atividadesController.text,
                          ) ??
                          aluno.atividades;

                  aluno.presenca =
                      int.tryParse(
                            presencaController.text,
                          ) ??
                          aluno.presenca;

                  aluno.responsavel =
                      responsavelController.text;

                  aluno.telefone =
                      telefoneController.text;

                  aluno.email =
                      emailController.text;

                  aluno.senha =
                      senhaController.text;
                });

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // CAMPO DE EDIÇÃO
  // ============================================================

  Widget _campoEditar({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType tipo = TextInputType.text,
    bool senha = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: tipo,
        obscureText: senha,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}