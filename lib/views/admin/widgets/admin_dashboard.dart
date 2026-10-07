import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  static const Color primaryColor = Color(0xFF565A9A);
  static const Color accentColor = Color(0xFFC56BE0);
  static const Color backgroundColor = Color(0xFFF5F1EA);

  String totalMes = 'R\$ 12.500';
  String doadoresAtivos = '48';

  String metaAtual = '12.500';
  String metaTotal = '15.000';

  String porcentagem = '83.3%';

  final List<Map<String, String>> doacoes = [
    {
      'nome': 'Ana Costa',
      'data': '17 de maio',
      'valor': 'R\$ 100',
      'metodo': 'PIX',
    },
    {
      'nome': 'Carlos Silva',
      'data': '15 de maio',
      'valor': 'R\$ 250',
      'metodo': 'Cartão',
    },
    {
      'nome': 'Mariana Souza',
      'data': '12 de maio',
      'valor': 'R\$ 80',
      'metodo': 'PIX',
    },
  ];

  final List<Map<String, dynamic>> meses = [
    {'mes': 'Dez', 'valor': 9000.0},
    {'mes': 'Jan', 'valor': 10800.0},
    {'mes': 'Fev', 'valor': 9750.0},
    {'mes': 'Mar', 'valor': 12300.0},
    {'mes': 'Abr', 'valor': 15000.0},
    {'mes': 'Mai', 'valor': 13200.0},
  ];

  double get _maiorValorGrafico => meses.fold<double>(
    0,
    (maior, item) => (item['valor'] as num).toDouble() > maior
        ? (item['valor'] as num).toDouble()
        : maior,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSummaryCards(),
                    const SizedBox(height: 20),
                    _buildMonthlyGoal(),
                    const SizedBox(height: 20),
                    _buildDonationChart(),
                    const SizedBox(height: 20),
                    _buildRecentDonations(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: primaryColor,
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: _abrirEdicaoDashboard,
            icon: const Icon(Icons.edit, color: Colors.white),
            tooltip: 'Editar Dashboard',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            titulo: 'Total do Mês',
            valor: totalMes,
            icone: Icons.attach_money,
            corIcone: accentColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            titulo: 'Doadores Ativos',
            valor: doadoresAtivos,
            icone: Icons.person_outline,
            corIcone: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String titulo,
    required String valor,
    required IconData icone,
    required Color corIcone,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  titulo,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ),
              Icon(icone, color: corIcone),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            valor,
            style: const TextStyle(
              color: accentColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyGoal() {
    final atual =
        double.tryParse(metaAtual.replaceAll('.', '').replaceAll(',', '.')) ??
        0;

    final total =
        double.tryParse(metaTotal.replaceAll('.', '').replaceAll(',', '.')) ??
        1;

    final progresso = (atual / total).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Meta Mensal',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              IconButton(
                onPressed: _editarMeta,
                icon: const Icon(Icons.edit, color: primaryColor),
              ),
            ],
          ),
          Text(
            'R\$ $metaAtual / $metaTotal',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progresso,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$porcentagem da meta alcançada',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationChart() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.show_chart, color: primaryColor),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Doações nos últimos 6 meses',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: _editarGrafico,
                icon: const Icon(Icons.edit, color: primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: meses.map((item) {
                return _buildChartBar(
                  item['mes'] as String,
                  (item['valor'] as num).toDouble(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(String mes, double valor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(_dinheiroCompacto(valor), style: const TextStyle(fontSize: 10)),
        const SizedBox(height: 4),
        Container(
          width: 25,
          height:
              (120 * valor / (_maiorValorGrafico == 0 ? 1 : _maiorValorGrafico))
                  .clamp(4.0, 120.0),
          decoration: const BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ),
        const SizedBox(height: 8),
        Text(mes, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
      ],
    );
  }

  Widget _buildRecentDonations() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Últimas Doações',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: _adicionarDoacao,
                icon: const Icon(Icons.add, color: primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...doacoes.asMap().entries.map((entry) {
            final index = entry.key;
            final doacao = entry.value;

            return Column(
              children: [
                _buildDonationItem(index, doacao),
                if (index < doacoes.length - 1) const Divider(),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDonationItem(int index, Map<String, String> doacao) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doacao['nome']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  doacao['data']!,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                doacao['valor']!,
                style: const TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                doacao['metodo']!,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              _editarDoacao(index);
            },
            icon: const Icon(Icons.edit_outlined, size: 20),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                doacoes.removeAt(index);
              });
            },
            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
          ),
        ],
      ),
    );
  }

  void _abrirEdicaoDashboard() {
    final totalController = TextEditingController(
      text: totalMes.replaceFirst('R\$ ', ''),
    );
    final doadoresController = TextEditingController(text: doadoresAtivos);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Editar Dashboard'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: totalController,
                  decoration: const InputDecoration(
                    labelText: 'Total do mês',
                    prefixText: 'R\$ ',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: doadoresController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Doadores ativos',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  totalMes = 'R\$ ${totalController.text}';
                  doadoresAtivos = doadoresController.text;
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _editarMeta() {
    final atualController = TextEditingController(text: metaAtual);
    final totalController = TextEditingController(text: metaTotal);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Editar Meta Mensal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: atualController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor atual'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: totalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Meta total'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  metaAtual = atualController.text;
                  metaTotal = totalController.text;

                  final atual =
                      double.tryParse(
                        metaAtual.replaceAll('.', '').replaceAll(',', '.'),
                      ) ??
                      0;

                  final total =
                      double.tryParse(
                        metaTotal.replaceAll('.', '').replaceAll(',', '.'),
                      ) ??
                      1;

                  porcentagem =
                      '${((atual / total) * 100).toStringAsFixed(1)}%';
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _editarGrafico() {
    final controllers = {
      for (final item in meses)
        item['mes'] as String: TextEditingController(
          text: (item['valor'] as num).toStringAsFixed(2),
        ),
    };

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Editar gráfico'),
        content: SizedBox(
          width: 430,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: meses.map((item) {
                final mes = item['mes'] as String;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: controllers[mes],
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Doações em $mes',
                      prefixText: 'R\$ ',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final valores = <String, double>{};
              for (final item in meses) {
                final mes = item['mes'] as String;
                final valor = double.tryParse(
                  controllers[mes]!.text.replaceAll(',', '.'),
                );
                if (valor == null || valor < 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Informe valores válidos e não negativos.'),
                    ),
                  );
                  return;
                }
                valores[mes] = valor;
              }
              setState(() {
                for (final item in meses) {
                  item['valor'] = valores[item['mes'] as String]!;
                }
              });
              Navigator.pop(dialogContext);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  String _dinheiroCompacto(double valor) => valor >= 1000
      ? 'R\$ ${(valor / 1000).toStringAsFixed(1)}k'
      : 'R\$ ${valor.toStringAsFixed(0)}';

  void _adicionarDoacao() {
    final nome = TextEditingController();
    final valor = TextEditingController();
    final data = TextEditingController();
    final metodo = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Adicionar Doação'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nome,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: data,
                  decoration: const InputDecoration(labelText: 'Data'),
                ),
                TextField(
                  controller: valor,
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                    prefixText: 'R\$ ',
                  ),
                ),
                TextField(
                  controller: metodo,
                  decoration: const InputDecoration(labelText: 'Método'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  doacoes.add({
                    'nome': nome.text,
                    'data': data.text,
                    'valor': 'R\$ ${valor.text}',
                    'metodo': metodo.text,
                  });
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _editarDoacao(int index) {
    final doacao = doacoes[index];

    final nome = TextEditingController(text: doacao['nome']);

    final data = TextEditingController(text: doacao['data']);

    final valor = TextEditingController(
      text: doacao['valor']!.replaceFirst('R\$ ', ''),
    );

    final metodo = TextEditingController(text: doacao['metodo']);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Editar Doação'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nome,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: data,
                  decoration: const InputDecoration(labelText: 'Data'),
                ),
                TextField(
                  controller: valor,
                  decoration: const InputDecoration(labelText: 'Valor'),
                ),
                TextField(
                  controller: metodo,
                  decoration: const InputDecoration(labelText: 'Método'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  doacoes[index] = {
                    'nome': nome.text,
                    'data': data.text,
                    'valor': 'R\$ ${valor.text}',
                    'metodo': metodo.text,
                  };
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}
