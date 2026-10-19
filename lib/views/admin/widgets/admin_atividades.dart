import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/atividade_model.dart';
import '../../../services/aluno_data_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/sql_connect_service.dart';

// ============================================================
// PÁGINA
// ============================================================

class AdminAtividadesPage extends StatefulWidget {
  final List<Atividade>? atividades;

  const AdminAtividadesPage({super.key, this.atividades});

  @override
  State<AdminAtividadesPage> createState() => _AdminAtividadesPageState();
}

class _AdminAtividadesPageState extends State<AdminAtividadesPage> {
  final List<Atividade> _atividades = [];
  bool _carregando = false;
  Object? _erro;

  List<Atividade> get atividades => widget.atividades ?? _atividades;

  String pesquisa = '';

  @override
  void initState() {
    super.initState();
    if (widget.atividades == null) {
      _carregando = true;
      unawaited(_carregarAtividades());
    }
  }

  Future<void> _carregarAtividades() async {
    try {
      final registros = await SqlConnectService.instance.listarAtividades();
      if (!mounted) return;
      setState(() {
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
        _erro = null;
        _carregando = false;
      });
    } catch (error, stackTrace) {
      debugPrint('Falha ao carregar atividades SQL: $error');
      debugPrint(stackTrace.toString());
      if (mounted) {
        setState(() {
          _erro = error;
          _carregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lista = atividades.where((atividade) {
      final texto = pesquisa.toLowerCase();

      return atividade.nome.toLowerCase().contains(texto) ||
          atividade.professor.toLowerCase().contains(texto) ||
          atividade.dias.toLowerCase().contains(texto) ||
          atividade.descricao.toLowerCase().contains(texto);
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          _cabecalho(),

          _campoBusca(),

          Expanded(
            child: _carregando
                ? const Center(child: CircularProgressIndicator())
                : _erro != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Não foi possível carregar as atividades.'),
                        const SizedBox(height: 8),
                        FilledButton(
                          onPressed: () {
                            setState(() => _carregando = true);
                            unawaited(_carregarAtividades());
                          },
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  )
                : lista.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma atividade encontrada.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),

                    itemCount: lista.length,

                    itemBuilder: (context, index) {
                      final atividade = lista[index];

                      return CardAtividade(
                        atividade: atividade,

                        onTap: () {
                          _mostrarDetalhes(atividade);
                        },

                        onEditar: () {
                          _editarAtividade(atividade);
                        },

                        onExcluir: () {
                          _removerAtividade(atividade);
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

      padding: const EdgeInsets.symmetric(horizontal: 12),

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

            icon: const Icon(Icons.add, color: Colors.white),

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
        maxLength: 100,
        onChanged: (valor) {
          setState(() {
            pesquisa = valor;
          });
        },

        decoration: InputDecoration(
          hintText: 'Buscar atividade, professor ou dia...',

          prefixIcon: const Icon(Icons.search),

          suffixIcon: pesquisa.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      pesquisa = '';
                    });
                  },

                  icon: const Icon(Icons.clear),
                )
              : null,

          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

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

  void _editarAtividade(Atividade atividade) {
    _abrirFormulario(atividade: atividade);
  }

  // ============================================================
  // FORMULÁRIO
  // ============================================================

  void _abrirFormulario({Atividade? atividade}) {
    final nomeController = TextEditingController(text: atividade?.nome ?? '');

    final professorController = TextEditingController(
      text: atividade?.professor ?? '',
    );

    final descricaoController = TextEditingController(
      text: atividade?.descricao ?? '',
    );

    final horarioController = TextEditingController(
      text: atividade?.horario ?? '',
    );

    final diasController = TextEditingController(text: atividade?.dias ?? '');

    final inscritosController = TextEditingController(
      text: '${atividade?.inscritos ?? 0}',
    );

    final vagasController = TextEditingController(
      text: '${atividade?.vagas ?? 20}',
    );

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(
            atividade == null ? 'Criar atividade' : 'Editar atividade',
          ),

          content: SizedBox(
            width: 500,

            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  _campo(
                    nomeController,
                    'Nome da atividade',
                    Icons.title,
                    maxLength: 80,
                  ),

                  _campo(
                    professorController,
                    'Professor',
                    Icons.person_outline,
                    maxLength: 100,
                  ),

                  _campo(
                    descricaoController,
                    'Descrição',
                    Icons.description_outlined,
                    maxLines: 4,
                    maxLength: 500,
                  ),

                  _campo(
                    horarioController,
                    'Horário',
                    Icons.access_time,
                    maxLength: 20,
                  ),

                  _campo(
                    diasController,
                    'Dias',
                    Icons.calendar_month_outlined,
                    maxLength: 50,
                  ),

                  _campo(
                    inscritosController,
                    'Inscritos',
                    Icons.people_outline,
                    tipo: TextInputType.number,
                    maxLength: 4,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    readOnly: true,
                  ),

                  _campo(
                    vagasController,
                    'Vagas',
                    Icons.event_seat_outlined,
                    tipo: TextInputType.number,
                    maxLength: 4,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

              child: const Text('Cancelar'),
            ),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF5552A6),
              ),

              onPressed: () async {
                final nome = nomeController.text.trim();

                final professor = professorController.text.trim();

                final descricao = descricaoController.text.trim();

                final horario = horarioController.text.trim();

                final dias = diasController.text.trim();

                final vagas = int.tryParse(vagasController.text);

                if (nome.isEmpty || professor.isEmpty || vagas == null) {
                  _mensagem('Preencha nome, professor e vagas.');
                  return;
                }

                if (nome.length > 80 || professor.length > 100) {
                  _mensagem(
                    'O nome da atividade deve ter até 80 caracteres e o professor até 100.',
                  );
                  return;
                }
                if (descricao.length > 500 ||
                    horario.length > 20 ||
                    dias.length > 50) {
                  _mensagem(
                    'Confira os limites da descrição, horário e dias da atividade.',
                  );
                  return;
                }

                if (vagas <= 0 || vagas > 9999) {
                  _mensagem(
                    'Informe uma quantidade válida de vagas (1 a 9999).',
                  );
                  return;
                }

                if (atividade != null && atividade.inscritos > vagas) {
                  _mensagem('Os inscritos não podem ser maiores que as vagas.');
                  return;
                }

                if (widget.atividades == null) {
                  try {
                    if (atividade == null) {
                      await SqlConnectService.instance.criarAtividade(
                        nome: nome,
                        professor: professor,
                        descricao: descricao,
                        horario: horario,
                        dias: dias,
                        vagas: vagas,
                        categoria: 'Geral',
                      );
                    } else {
                      await SqlConnectService.instance.atualizarAtividade(
                        id: atividade.id,
                        nome: nome,
                        professor: professor,
                        descricao: descricao,
                        horario: horario,
                        dias: dias,
                        vagas: vagas,
                        categoria: atividade.categoria,
                        status: atividade.status,
                      );
                    }
                    await _carregarAtividades();
                  } catch (error, stackTrace) {
                    debugPrint('Falha ao salvar atividade SQL: $error');
                    debugPrint(stackTrace.toString());
                    _mensagem(AuthService.mensagemErro(error));
                    return;
                  }
                } else {
                  setState(() {
                    if (atividade == null) {
                      atividades.add(
                        Atividade(
                          id: 'atv-${DateTime.now().millisecondsSinceEpoch}',
                          nome: nome,
                          professor: professor,
                          descricao: descricao,
                          horario: horario,
                          dias: dias,
                          inscritos: 0,
                          vagas: vagas,
                          categoria: 'Geral',
                        ),
                      );
                    } else {
                      atividade.nome = nome;
                      atividade.professor = professor;
                      atividade.descricao = descricao;
                      atividade.horario = horario;
                      atividade.dias = dias;
                      atividade.vagas = vagas;
                    }
                  });
                  AlunoDataService.instance.notificarAlteracao();
                }

                if (context.mounted) Navigator.pop(context);

                _mensagem(
                  atividade == null
                      ? 'Atividade criada!'
                      : 'Atividade atualizada!',
                );
              },

              child: Text(atividade == null ? 'Criar' : 'Salvar'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // REMOVER
  // ============================================================

  void _removerAtividade(Atividade atividade) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Remover atividade?'),

          content: Text('Deseja realmente remover "${atividade.nome}"?'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Cancelar'),
            ),

            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),

              onPressed: () async {
                setState(() {
                  if (widget.atividades != null) {
                    atividades.remove(atividade);
                  }
                });

                if (widget.atividades == null) {
                  try {
                    await SqlConnectService.instance.atualizarAtividade(
                      id: atividade.id,
                      nome: atividade.nome,
                      professor: atividade.professor,
                      descricao: atividade.descricao,
                      horario: atividade.horario,
                      dias: atividade.dias,
                      vagas: atividade.vagas,
                      categoria: atividade.categoria,
                      status: 'inativa',
                    );
                    await _carregarAtividades();
                  } catch (error, stackTrace) {
                    debugPrint('Falha ao arquivar atividade SQL: $error');
                    debugPrint(stackTrace.toString());
                    _mensagem(AuthService.mensagemErro(error));
                    return;
                  }
                } else {
                  AlunoDataService.instance.notificarAlteracao();
                }

                if (context.mounted) Navigator.pop(context);

                _mensagem(
                  widget.atividades == null
                      ? 'Atividade arquivada.'
                      : 'Atividade removida!',
                );
              },

              child: const Text('Remover'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // DETALHES
  // ============================================================

  void _mostrarDetalhes(Atividade atividade) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(atividade.nome),

          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(atividade.descricao),

                const SizedBox(height: 15),

                Text('Professor: ${atividade.professor}'),

                Text('Horário: ${atividade.horario}'),

                Text('Dias: ${atividade.dias}'),

                Text('Inscritos: ${atividade.inscritos}'),

                Text('Vagas: ${atividade.vagas}'),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Fechar'),
            ),

            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                _editarAtividade(atividade);
              },

              child: const Text('Editar'),
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
    TextInputType tipo = TextInputType.text,
    int maxLines = 1,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: TextField(
        controller: controller,
        keyboardType: tipo,
        maxLines: maxLines,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        readOnly: readOnly,

        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  void _mensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
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
    final ocupacao = atividade.vagas > 0
        ? (atividade.inscritos / atividade.vagas).clamp(0.0, 1.0)
        : 0.0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFD9D9E5)),
      ),

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(17),

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,

                    decoration: BoxDecoration(
                      color: atividade.cor.withValues(alpha: 0.1),

                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: atividade.cor,
                    ),
                  ),

                  const SizedBox(width: 13),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          atividade.nome,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          atividade.professor,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Text(
                atividade.descricao,
                style: const TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 15),

              Text('${atividade.horario} • ${atividade.dias}'),

              const SizedBox(height: 8),

              Text('${atividade.inscritos} / ${atividade.vagas} vagas'),

              const SizedBox(height: 8),

              LinearProgressIndicator(value: ocupacao, color: atividade.cor),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  IconButton(
                    tooltip: 'Editar',
                    onPressed: onEditar,

                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFF5552A6),
                    ),
                  ),

                  IconButton(
                    tooltip: 'Excluir',
                    onPressed: onExcluir,

                    icon: const Icon(Icons.delete_outline, color: Colors.red),
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
