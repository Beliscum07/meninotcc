import 'package:flutter/material.dart';

class Atividade {
  String nome;
  String professor;
  String descricao;
  String horario;
  String dias;

  int inscritos;
  int vagas;

  Color cor;

  Atividade({
    required this.nome,
    required this.professor,
    required this.descricao,
    required this.horario,
    required this.dias,
    required this.inscritos,
    required this.vagas,
    required this.cor,
  });
}

// ============================================================
// DADOS INICIAIS
// ============================================================

final List<Atividade> atividadesMock = [
  Atividade(
    nome: 'Música e Coral',
    professor: 'Prof. Carlos Mendes',
    descricao:
        'Aulas de canto e prática coral para desenvolvimento musical.',
    horario: '14:00 - 16:00',
    dias: 'Seg, Qua',
    inscritos: 15,
    vagas: 20,
    cor: const Color(0xFFE778E8),
  ),

  Atividade(
    nome: 'Arte e Pintura',
    professor: 'Prof. Beatriz Costa',
    descricao:
        'Expressão artística através de diferentes técnicas de pintura.',
    horario: '15:00 - 17:00',
    dias: 'Ter, Qui',
    inscritos: 12,
    vagas: 15,
    cor: const Color(0xFFF25A0A),
  ),

  Atividade(
    nome: 'Dança e Movimento',
    professor: 'Prof. Amanda Rodrigues',
    descricao:
        'Aulas de dança para desenvolvimento motor e expressão corporal.',
    horario: '16:00 - 18:00',
    dias: 'Seg, Sex',
    inscritos: 20,
    vagas: 25,
    cor: const Color(0xFFF25A0A),
  ),

  Atividade(
    nome: 'Esportes e Jogos',
    professor: 'Prof. Rafael Santos',
    descricao:
        'Atividades esportivas e jogos recreativos.',
    horario: '14:00 - 16:00',
    dias: 'Qua, Sex',
    inscritos: 18,
    vagas: 25,
    cor: const Color(0xFFF0A06D),
  ),
];

// ============================================================
// PÁGINA
// ============================================================

class AdminAtividadesPage extends StatefulWidget {
  final List<Atividade>? atividades;

  const AdminAtividadesPage({
    super.key,
    this.atividades,
  });

  @override
  State<AdminAtividadesPage> createState() =>
      _AdminAtividadesPageState();
}

class _AdminAtividadesPageState
    extends State<AdminAtividadesPage> {
  late List<Atividade> atividades;

  String pesquisa = '';

  @override
  void initState() {
    super.initState();

    atividades =
        widget.atividades ?? atividadesMock;
  }

  @override
  Widget build(BuildContext context) {
    final lista = atividades.where((atividade) {
      final texto = pesquisa.toLowerCase();

      return atividade.nome
              .toLowerCase()
              .contains(texto) ||
          atividade.professor
              .toLowerCase()
              .contains(texto) ||
          atividade.dias
              .toLowerCase()
              .contains(texto) ||
          atividade.descricao
              .toLowerCase()
              .contains(texto);
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          _cabecalho(),

          _campoBusca(),

          Expanded(
            child: lista.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma atividade encontrada.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.all(12),

                    itemCount: lista.length,

                    itemBuilder: (context, index) {
                      final atividade =
                          lista[index];

                      return CardAtividade(
                        atividade: atividade,

                        onTap: () {
                          _mostrarDetalhes(
                            atividade,
                          );
                        },

                        onEditar: () {
                          _editarAtividade(
                            atividade,
                          );
                        },

                        onExcluir: () {
                          _removerAtividade(
                            atividade,
                          );
                        },
                      );
                    },
                  ),
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

      padding:
          const EdgeInsets.symmetric(horizontal: 12),

      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Gestão de Atividades',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          IconButton(
            onPressed: _criarAtividade,

            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),

            tooltip: 'Criar atividade',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUSCA
  // ============================================================

  Widget _campoBusca() {
    return Padding(
      padding: const EdgeInsets.all(12),

      child: TextField(
        onChanged: (valor) {
          setState(() {
            pesquisa = valor;
          });
        },

        decoration: InputDecoration(
          hintText:
              'Buscar atividade, professor ou dia...',

          prefixIcon:
              const Icon(Icons.search),

          suffixIcon: pesquisa.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      pesquisa = '';
                    });
                  },

                  icon:
                      const Icon(Icons.clear),
                )
              : null,

          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(16),

            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CRIAR
  // ============================================================

  void _criarAtividade() {
    _abrirFormulario();
  }

  // ============================================================
  // EDITAR
  // ============================================================

  void _editarAtividade(
    Atividade atividade,
  ) {
    _abrirFormulario(
      atividade: atividade,
    );
  }

  // ============================================================
  // FORMULÁRIO
  // ============================================================

  void _abrirFormulario({
    Atividade? atividade,
  }) {
    final nomeController =
        TextEditingController(
      text: atividade?.nome ?? '',
    );

    final professorController =
        TextEditingController(
      text: atividade?.professor ?? '',
    );

    final descricaoController =
        TextEditingController(
      text: atividade?.descricao ?? '',
    );

    final horarioController =
        TextEditingController(
      text: atividade?.horario ?? '',
    );

    final diasController =
        TextEditingController(
      text: atividade?.dias ?? '',
    );

    final inscritosController =
        TextEditingController(
      text: '${atividade?.inscritos ?? 0}',
    );

    final vagasController =
        TextEditingController(
      text: '${atividade?.vagas ?? 20}',
    );

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(
            atividade == null
                ? 'Criar atividade'
                : 'Editar atividade',
          ),

          content: SizedBox(
            width: 500,

            child: SingleChildScrollView(
              child: Column(
                mainAxisSize:
                    MainAxisSize.min,

                children: [
                  _campo(
                    nomeController,
                    'Nome da atividade',
                    Icons.title,
                  ),

                  _campo(
                    professorController,
                    'Professor',
                    Icons.person_outline,
                  ),

                  _campo(
                    descricaoController,
                    'Descrição',
                    Icons.description_outlined,
                    maxLines: 3,
                  ),

                  _campo(
                    horarioController,
                    'Horário',
                    Icons.access_time,
                  ),

                  _campo(
                    diasController,
                    'Dias',
                    Icons.calendar_month_outlined,
                  ),

                  _campo(
                    inscritosController,
                    'Inscritos',
                    Icons.people_outline,
                    tipo:
                        TextInputType.number,
                  ),

                  _campo(
                    vagasController,
                    'Vagas',
                    Icons.event_seat_outlined,
                    tipo:
                        TextInputType.number,
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

              child:
                  const Text('Cancelar'),
            ),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor:
                    const Color(0xFF5552A6),
              ),

              onPressed: () {
                final nome =
                    nomeController.text.trim();

                final professor =
                    professorController.text.trim();

                final descricao =
                    descricaoController.text.trim();

                final horario =
                    horarioController.text.trim();

                final dias =
                    diasController.text.trim();

                final inscritos =
                    int.tryParse(
                          inscritosController
                              .text,
                        ) ??
                        0;

                final vagas =
                    int.tryParse(
                          vagasController.text,
                        ) ??
                        0;

                if (nome.isEmpty ||
                    professor.isEmpty ||
                    vagas <= 0) {
                  _mensagem(
                    'Preencha nome, professor e vagas.',
                  );
                  return;
                }

                if (inscritos > vagas) {
                  _mensagem(
                    'Os inscritos não podem ser maiores que as vagas.',
                  );
                  return;
                }

                setState(() {
                  if (atividade == null) {
                    atividades.add(
                      Atividade(
                        nome: nome,
                        professor: professor,
                        descricao: descricao,
                        horario: horario,
                        dias: dias,
                        inscritos: inscritos,
                        vagas: vagas,
                        cor: const Color(
                          0xFFE778E8,
                        ),
                      ),
                    );
                  } else {
                    atividade.nome = nome;
                    atividade.professor =
                        professor;
                    atividade.descricao =
                        descricao;
                    atividade.horario =
                        horario;
                    atividade.dias = dias;
                    atividade.inscritos =
                        inscritos;
                    atividade.vagas = vagas;
                  }
                });

                Navigator.pop(context);

                _mensagem(
                  atividade == null
                      ? 'Atividade criada!'
                      : 'Atividade atualizada!',
                );
              },

              child: Text(
                atividade == null
                    ? 'Criar'
                    : 'Salvar',
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // REMOVER
  // ============================================================

  void _removerAtividade(
    Atividade atividade,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title:
              const Text('Remover atividade?'),

          content: Text(
            'Deseja realmente remover "${atividade.nome}"?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child:
                  const Text('Cancelar'),
            ),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              onPressed: () {
                setState(() {
                  atividades.remove(
                    atividade,
                  );
                });

                Navigator.pop(context);

                _mensagem(
                  'Atividade removida!',
                );
              },

              child:
                  const Text('Remover'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // DETALHES
  // ============================================================

  void _mostrarDetalhes(
    Atividade atividade,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(atividade.nome),

          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  atividade.descricao,
                ),

                const SizedBox(height: 15),

                Text(
                  'Professor: ${atividade.professor}',
                ),

                Text(
                  'Horário: ${atividade.horario}',
                ),

                Text(
                  'Dias: ${atividade.dias}',
                ),

                Text(
                  'Inscritos: ${atividade.inscritos}',
                ),

                Text(
                  'Vagas: ${atividade.vagas}',
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child:
                  const Text('Fechar'),
            ),

            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                _editarAtividade(
                  atividade,
                );
              },

              child:
                  const Text('Editar'),
            ),
          ],
        );
      },
    );
  }

  Widget _campo(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType tipo =
        TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 12),

      child: TextField(
        controller: controller,
        keyboardType: tipo,
        maxLines: maxLines,

        decoration: InputDecoration(
          labelText: label,
          prefixIcon:
              Icon(icon),

          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _mensagem(String texto) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(texto),
      ),
    );
  }
}

// ============================================================
// CARD DE ATIVIDADE
// ============================================================

class CardAtividade extends StatelessWidget {
  final Atividade atividade;

  final VoidCallback onTap;
  final VoidCallback onEditar;
  final VoidCallback onExcluir;

  const CardAtividade({
    super.key,
    required this.atividade,
    required this.onTap,
    required this.onEditar,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    final ocupacao =
        atividade.vagas > 0
            ? (atividade.inscritos /
                    atividade.vagas)
                .clamp(0.0, 1.0)
            : 0.0;

    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(17),
        border: Border.all(
          color:
              const Color(0xFFD9D9E5),
        ),
      ),

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(17),

        child: Padding(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,

                    decoration:
                        BoxDecoration(
                      color: atividade.cor
                          .withOpacity(0.1),

                      borderRadius:
                          BorderRadius.circular(
                        15,
                      ),
                    ),

                    child: Icon(
                      Icons
                          .calendar_month_outlined,
                      color:
                          atividade.cor,
                    ),
                  ),

                  const SizedBox(
                    width: 13,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          atividade.nome,
                          style:
                              const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          atividade.professor,
                          style:
                              const TextStyle(
                            color:
                                Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              Text(
                atividade.descricao,
                style:
                    const TextStyle(
                  color:
                      Colors.black54,
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              Text(
                '${atividade.horario} • ${atividade.dias}',
              ),

              const SizedBox(
                height: 8,
              ),

              Text(
                '${atividade.inscritos} / ${atividade.vagas} vagas',
              ),

              const SizedBox(
                height: 8,
              ),

              LinearProgressIndicator(
                value: ocupacao,
                color: atividade.cor,
              ),

              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,

                children: [
                  IconButton(
                    tooltip: 'Editar',
                    onPressed: onEditar,

                    icon: const Icon(
                      Icons.edit_outlined,
                      color:
                          Color(0xFF5552A6),
                    ),
                  ),

                  IconButton(
                    tooltip: 'Excluir',
                    onPressed: onExcluir,

                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}