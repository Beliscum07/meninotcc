import 'package:flutter/material.dart';

class Bolsa {
  String nome;
  String descricao;
  int beneficiarios;
  double valorMensal;
  bool ativa;

  Bolsa({
    required this.nome,
    required this.descricao,
    required this.beneficiarios,
    required this.valorMensal,
    required this.ativa,
  });

  double get investimento {
    return beneficiarios * valorMensal;
  }
}

// ============================================================
// BOLSAS INICIAIS
// ============================================================

final List<Bolsa> bolsasMock = [
  Bolsa(
    nome: 'Bolsa Educação Integral',
    descricao: 'Apoio completo para educação e material escolar.',
    beneficiarios: 25,
    valorMensal: 300,
    ativa: true,
  ),

  Bolsa(
    nome: 'Bolsa Esporte e Cultura',
    descricao: 'Auxílio para atividades esportivas e culturais.',
    beneficiarios: 15,
    valorMensal: 150,
    ativa: true,
  ),

  Bolsa(
    nome: 'Bolsa Alimentação',
    descricao: 'Auxílio para alimentação dos beneficiários.',
    beneficiarios: 40,
    valorMensal: 200,
    ativa: true,
  ),
];

// ============================================================
// PÁGINA
// ============================================================

class AdminBolsas extends StatefulWidget {
  const AdminBolsas({super.key});

  @override
  State<AdminBolsas> createState() => _AdminBolsasState();
}

class _AdminBolsasState extends State<AdminBolsas> {
  final List<Bolsa> bolsas = List.from(bolsasMock);

  String pesquisa = '';

  @override
  Widget build(BuildContext context) {
    final lista = bolsas.where((bolsa) {
      final texto = pesquisa.toLowerCase();

      return bolsa.nome.toLowerCase().contains(texto) ||
          bolsa.descricao.toLowerCase().contains(texto);
    }).toList();

    final bolsasAtivas = bolsas.where((b) => b.ativa);

    final totalBeneficiarios = bolsasAtivas.fold<int>(
      0,
      (total, bolsa) => total + bolsa.beneficiarios,
    );

    final investimentoTotal = bolsasAtivas.fold<double>(
      0,
      (total, bolsa) => total + bolsa.investimento,
    );

    return Container(
      color: const Color(0xFFF5F1EA),

      child: SafeArea(
        child: Column(
          children: [
            _cabecalho(),

            _campoBusca(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    _resumo(totalBeneficiarios, investimentoTotal),

                    const SizedBox(height: 24),

                    if (lista.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(40),

                        child: Text(
                          'Nenhuma bolsa encontrada.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    else
                      ...lista.map(
                        (bolsa) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),

                          child: _cardBolsa(bolsa),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CABEÇALHO
  // ============================================================

  Widget _cabecalho() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

      color: const Color(0xFF565A9A),

      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Programas de Bolsas',

              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          IconButton(
            onPressed: _adicionarBolsa,

            icon: const Icon(Icons.add, color: Colors.white),

            tooltip: 'Adicionar bolsa',
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
          hintText: 'Buscar bolsa...',

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
  // RESUMO
  // ============================================================

  Widget _resumo(int beneficiarios, double investimento) {
    return Row(
      children: [
        Expanded(
          child: _cardResumo(
            Icons.people_outline,
            'Beneficiados',
            '$beneficiarios',
            const Color(0xFFC56BE0),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _cardResumo(
            Icons.attach_money,
            'Total/Mês',
            _dinheiro(investimento),
            const Color(0xFF565A9A),
          ),
        ),
      ],
    );
  }

  Widget _cardResumo(IconData icone, String titulo, String valor, Color cor) {
    return Container(
      height: 100,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: const Color(0xFFD9D9D9)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(icone, color: cor),

              const SizedBox(width: 8),

              Expanded(
                child: Text(titulo, style: const TextStyle(color: Colors.grey)),
              ),
            ],
          ),

          const Spacer(),

          Text(
            valor,

            style: TextStyle(
              color: cor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD DA BOLSA
  // ============================================================

  Widget _cardBolsa(Bolsa bolsa) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: const Color(0xFFD9D9D9)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB96DD9), Color(0xFF565A9A)],
                  ),

                  borderRadius: BorderRadius.circular(16),
                ),

                child: const Icon(
                  Icons.workspace_premium_outlined,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            bolsa.nome,

                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color: bolsa.ativa
                                ? const Color(0xFFDDF1E5)
                                : Colors.grey.shade200,

                            borderRadius: BorderRadius.circular(8),
                          ),

                          child: Text(
                            bolsa.ativa ? 'Ativo' : 'Inativo',

                            style: TextStyle(
                              color: bolsa.ativa
                                  ? const Color(0xFF39835A)
                                  : Colors.grey,

                              fontSize: 12,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      bolsa.descricao,

                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _infoBox('Beneficiários', '${bolsa.beneficiarios}'),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _infoBox('Valor mensal', _dinheiro(bolsa.valorMensal)),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Divider(),

          Row(
            children: [
              Expanded(
                child: Text(
                  'Investimento: '
                  '${_dinheiro(bolsa.investimento)}',

                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              IconButton(
                tooltip: 'Editar',

                onPressed: () {
                  _editarBolsa(bolsa);
                },

                icon: const Icon(Icons.edit_outlined, color: Color(0xFF565A9A)),
              ),

              IconButton(
                tooltip: 'Excluir',

                onPressed: () {
                  _removerBolsa(bolsa);
                },

                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String titulo, String valor) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: const Color(0xFFF0EEF5),

        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            titulo,

            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),

          const SizedBox(height: 6),

          Text(
            valor,

            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ADICIONAR / EDITAR
  // ============================================================

  void _adicionarBolsa() {
    _abrirFormulario();
  }

  void _editarBolsa(Bolsa bolsa) {
    _abrirFormulario(bolsa: bolsa);
  }

  void _abrirFormulario({Bolsa? bolsa}) {
    final nomeController = TextEditingController(text: bolsa?.nome ?? '');

    final descricaoController = TextEditingController(
      text: bolsa?.descricao ?? '',
    );

    final beneficiariosController = TextEditingController(
      text: '${bolsa?.beneficiarios ?? 0}',
    );

    final valorController = TextEditingController(
      text: '${bolsa?.valorMensal ?? 0}',
    );

    bool ativa = bolsa?.ativa ?? true;

    showDialog(
      context: context,

      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(bolsa == null ? 'Adicionar bolsa' : 'Editar bolsa'),

              content: SizedBox(
                width: 450,

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      _campo(
                        nomeController,
                        'Nome da bolsa',
                        Icons.title,
                        maxLength: 50,
                      ),

                      _campo(
                        descricaoController,
                        'Descrição',
                        Icons.description_outlined,
                        maxLines: 5,
                        maxLength: 500,
                      ),

                      _campo(
                        beneficiariosController,
                        'Beneficiários',
                        Icons.people_outline,
                        tipo: TextInputType.number,
                      ),

                      _campo(
                        valorController,
                        'Valor mensal',
                        Icons.attach_money,
                        tipo: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),

                      SwitchListTile(
                        title: const Text('Bolsa ativa'),

                        value: ativa,

                        onChanged: (valor) {
                          setDialogState(() {
                            ativa = valor;
                          });
                        },
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
                  onPressed: () {
                    final nome = nomeController.text.trim();

                    final descricao = descricaoController.text.trim();

                    final beneficiarios =
                        int.tryParse(beneficiariosController.text) ?? 0;

                    final valor =
                        double.tryParse(
                          valorController.text.replaceAll(',', '.'),
                        ) ??
                        0;

                    if (nome.isEmpty) {
                      _mensagem('Informe o nome da bolsa.');
                      return;
                    }

                    if (nome.length > 50) {
                      _mensagem(
                        'O nome da bolsa pode ter no máximo 50 caracteres.',
                      );
                      return;
                    }

                    if (descricao.length > 500) {
                      _mensagem(
                        'A descrição pode ter no máximo 500 caracteres.',
                      );
                      return;
                    }

                    if (beneficiarios < 0 || valor < 0) {
                      _mensagem('Preencha os dados corretamente.');

                      return;
                    }

                    setState(() {
                      if (bolsa == null) {
                        bolsas.add(
                          Bolsa(
                            nome: nome,
                            descricao: descricao,
                            beneficiarios: beneficiarios,
                            valorMensal: valor,
                            ativa: ativa,
                          ),
                        );
                      } else {
                        bolsa.nome = nome;
                        bolsa.descricao = descricao;
                        bolsa.beneficiarios = beneficiarios;
                        bolsa.valorMensal = valor;
                        bolsa.ativa = ativa;
                      }
                    });

                    Navigator.pop(context);

                    _mensagem(
                      bolsa == null ? 'Bolsa adicionada!' : 'Bolsa atualizada!',
                    );
                  },

                  child: Text(bolsa == null ? 'Adicionar' : 'Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ============================================================
  // REMOVER
  // ============================================================

  void _removerBolsa(Bolsa bolsa) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Remover bolsa?'),

          content: Text('Deseja realmente remover "${bolsa.nome}"?'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Cancelar'),
            ),

            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),

              onPressed: () {
                setState(() {
                  bolsas.remove(bolsa);
                });

                Navigator.pop(context);

                _mensagem('Bolsa removida!');
              },

              child: const Text('Remover'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // FORM
  // ============================================================

  Widget _campo(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType tipo = TextInputType.text,
    int maxLines = 1,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: TextField(
        controller: controller,
        keyboardType: tipo,
        maxLines: maxLines,
        maxLength: maxLength,

        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  String _dinheiro(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  void _mensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }
}
