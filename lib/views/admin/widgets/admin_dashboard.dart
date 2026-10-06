import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final Color primaryColor = const Color(0xFF565A9A);
  final Color accentColor = const Color(0xFFC56BE0);

  // ==========================================================
  // VALOR TOTAL DO PIX
  // ==========================================================

  double totalPix = 12500.00;

  // ==========================================================
  // VALORES DO GRÁFICO
  // ==========================================================
  //
  // Cada mês possui um valor que pode ser editado.
  //

  final List<Map<String, dynamic>> months = [
    {
      'month': 'Dez',
      'value': 600.0,
    },
    {
      'month': 'Jan',
      'value': 720.0,
    },
    {
      'month': 'Fev',
      'value': 650.0,
    },
    {
      'month': 'Mar',
      'value': 820.0,
    },
    {
      'month': 'Abr',
      'value': 1000.0,
    },
    {
      'month': 'Mai',
      'value': 880.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // CABEÇALHO
  // ==========================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      color: primaryColor,
      child: const Text(
        'Dashboard',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ==========================================================
  // CARDS SUPERIORES
  // ==========================================================

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            title: 'Total do Mês',
            value: _formatarReais(totalPix),
            icon: Icons.attach_money,
            subtitle: 'Valor atualizado pelo administrador',
            iconColor: accentColor,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _buildInfoCard(
            title: 'Doadores\nAtivos',
            value: '48',
            icon: Icons.person_outline,
            iconColor: primaryColor,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // CARD
  // ==========================================================

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
    String? subtitle,
    required Color iconColor,
  }) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 145,
      ),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ),

              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: TextStyle(
              color: accentColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (subtitle != null) ...[
            const Spacer(),

            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 11,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ==========================================================
  // META MENSAL
  // ==========================================================

  Widget _buildMonthlyGoal() {
    const double meta = 15000;

    double progresso = totalPix / meta;

    if (progresso < 0) {
      progresso = 0;
    }

    if (progresso > 1) {
      progresso = 1;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meta Mensal',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      '${_formatarReais(totalPix)} / ${_formatarReais(meta)}',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.radio_button_checked,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progresso,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation(
                accentColor,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '${(progresso * 100).toStringAsFixed(1)}% da meta alcançada',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _abrirLancamentoPix,
              icon: const Icon(Icons.edit),
              label: const Text(
                'Atualizar valor do PIX',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // EDITAR PIX
  // ==========================================================

  void _abrirLancamentoPix() {
    final TextEditingController valorController =
        TextEditingController();

    final TextEditingController descricaoController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Atualizar valor do PIX',
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Digite um valor positivo para adicionar dinheiro '
                'ou negativo para registrar um gasto.',
              ),

              const SizedBox(height: 15),

              TextField(
                controller: valorController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  hintText: 'Ex: 100 ou -100',
                  prefixText: 'R\$ ',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Ex: Doação ou gasto da ONG',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),

            ElevatedButton(
              onPressed: () {
                _adicionarValorPix(
                  valorController.text,
                  descricaoController.text,
                );

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // ADICIONAR / RETIRAR DO PIX
  // ==========================================================

  void _adicionarValorPix(
    String valorTexto,
    String descricao,
  ) {
    String valorFormatado = valorTexto
        .replaceAll('.', '')
        .replaceAll(',', '.');

    final double? valor = double.tryParse(valorFormatado);

    if (valor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite um valor válido.',
          ),
        ),
      );

      return;
    }

    setState(() {
      totalPix += valor;
    });

    String mensagem;

    if (valor >= 0) {
      mensagem =
          'Adicionado ${_formatarReais(valor)} ao PIX.';
    } else {
      mensagem =
          'Retirado ${_formatarReais(valor.abs())} do PIX.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
      ),
    );
  }

  // ==========================================================
  // GRÁFICO DE COLUNAS
  // ==========================================================

  Widget _buildDonationChart() {
    // Descobre qual é o maior valor.
    double maiorValor = 0;

    for (final mes in months) {
      final double valor = mes['value'];

      if (valor > maiorValor) {
        maiorValor = valor;
      }
    }

    // Evita divisão por zero.
    if (maiorValor == 0) {
      maiorValor = 1;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                color: primaryColor,
                size: 22,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  'Doações nos últimos 6 meses',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            'Clique em uma coluna para editar o valor.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 25),

          // ==================================================
          // COLUNAS
          // ==================================================

          SizedBox(
            height: 240,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: months.map((data) {
                final String mes = data['month'];
                final double valor = data['value'];

                // Calcula o tamanho da coluna.
                double altura = (valor / maiorValor) * 150;

                // Altura mínima para valores pequenos.
                if (altura < 10 && valor > 0) {
                  altura = 10;
                }

                return GestureDetector(
                  onTap: () {
                    _editarValorGrafico(
                      mes,
                      valor,
                    );
                  },
                  child: _buildChartBar(
                    mes,
                    valor,
                    altura,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // COLUNA INDIVIDUAL
  // ==========================================================

  Widget _buildChartBar(
    String month,
    double value,
    double height,
  ) {
    return SizedBox(
      width: 45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // ==================================================
          // NÚMERO ACIMA DA COLUNA
          // ==================================================

          Text(
            _formatarReais(value),
            style: TextStyle(
              color: primaryColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 5),

          // ==================================================
          // COLUNA
          // ==================================================

          Container(
            width: 30,
            height: height,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(7),
              ),
            ),
          ),

          const SizedBox(height: 7),

          // ==================================================
          // NOME DO MÊS
          // ==================================================

          Text(
            month,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // EDITAR VALOR DO GRÁFICO
  // ==========================================================

  void _editarValorGrafico(
    String mes,
    double valorAtual,
  ) {
    final TextEditingController controller =
        TextEditingController(
      text: valorAtual.toStringAsFixed(2).replaceAll('.', ','),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Editar $mes',
          ),

          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Valor das doações',
              hintText: 'Ex: 1500,00',
              prefixText: 'R\$ ',
              border: OutlineInputBorder(),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                String texto = controller.text
                    .replaceAll('.', '')
                    .replaceAll(',', '.');

                final double? novoValor =
                    double.tryParse(texto);

                if (novoValor == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Digite um valor válido.',
                      ),
                    ),
                  );

                  return;
                }

                setState(() {
                  // Procura o mês que foi clicado
                  // e troca o valor dele.
                  for (final item in months) {
                    if (item['month'] == mes) {
                      item['value'] = novoValor;
                      break;
                    }
                  }
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '$mes atualizado para '
                      '${_formatarReais(novoValor)}.',
                    ),
                  ),
                );
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

  // ==========================================================
  // ÚLTIMAS DOAÇÕES
  // ==========================================================

  Widget _buildRecentDonations() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Últimas Doações',
            style: TextStyle(
              color: primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          _buildDonationItem(
            name: 'Ana Costa',
            date: '17 de maio',
            value: 'R\$ 100',
            method: 'PIX',
          ),

          const Divider(),

          _buildDonationItem(
            name: 'Carlos Silva',
            date: '15 de maio',
            value: 'R\$ 250',
            method: 'Cartão',
          ),

          const Divider(),

          _buildDonationItem(
            name: 'Mariana Souza',
            date: '12 de maio',
            value: 'R\$ 80',
            method: 'PIX',
          ),
        ],
      ),
    );
  }

  Widget _buildDonationItem({
    required String name,
    required String date,
    required String value,
    required String method,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                method,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // FORMATAÇÃO DE DINHEIRO
  // ==========================================================

  String _formatarReais(double valor) {
    final bool negativo = valor < 0;

    final double valorAbsoluto = valor.abs();

    final String numero = valorAbsoluto
        .toStringAsFixed(2)
        .replaceAll('.', ',');

    return '${negativo ? '-' : ''}R\$ $numero';
  }

  // ==========================================================
  // ESTILO DOS CARDS
  // ==========================================================

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFFFDFDFD),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.grey.shade300,
      ),
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