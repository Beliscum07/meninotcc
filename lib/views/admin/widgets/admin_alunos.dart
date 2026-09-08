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
    ),
    Aluno(
      nome: 'Ana Clara Santos',
      idade: 10,
      id: '002',
      atividades: 2,
      presenca: 88,
      responsavel: 'José Santos',
      telefone: '(11) 98765-1234',
    ),
    Aluno(
      nome: 'Lucas Oliveira',
      idade: 8,
      id: '003',
      atividades: 2,
      presenca: 95,
      responsavel: 'Carla Oliveira',
      telefone: '(11) 98765-5678',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _cabecalho(),
          Expanded(child: _telaAlunos()),
        ],
      ),
    );
  }

  // CABEÇALHO

  Widget _cabecalho() {
    const String titulo = 'Gestão de Alunos';

    return Container(
      height: 62,
      width: double.infinity,
      color: const Color(0xFF5558AD),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        titulo,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // TELA DE ALUNOS
  Widget _telaAlunos() {
    final listaFiltrada = alunos.where((aluno) {
      return aluno.nome.toLowerCase().contains(
            pesquisa.toLowerCase(),
          );
    }).toList();

    return Column(
      children: [
        // Campo de pesquisa
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

        // Lista
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
    if (widget.onOpenAluno != null) widget.onOpenAluno!(aluno);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                aluno.nome,
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text('Idade: ${aluno.idade} anos'),
              Text('ID: ${aluno.id}'),
              Text('Atividades: ${aluno.atividades}'),
              Text('Presença: ${aluno.presenca}%'),
              const SizedBox(height: 12),
              Text('Responsável: ${aluno.responsavel}'),
              Text('Telefone: ${aluno.telefone}'),
            ],
          ),
        );
      },
    );
  }

  // EDITAR ALUNO

  void _editarAluno(Aluno aluno) {
    final controller = TextEditingController(
      text: aluno.nome,
    );

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Editar aluno'),

          content: TextField(
            controller: controller,

            decoration: const InputDecoration(
              labelText: 'Nome',
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Cancelar'),
            ),

            FilledButton(
              onPressed: () {
                setState(() {
                  aluno.nome = controller.text;
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

}


// Modelo `Aluno` foi movido para lib/models/student_model.dart

// Modelo e widget `CardAluno` foram movidos para:
// - lib/models/student_model.dart
// - lib/views/admin/widgets/card_aluno.dart

// ================================================================
// CARD DE ATIVIDADE
// ================================================================
// Card de atividade está agora em lib/views/admin/widgets/admin_atividades.dart