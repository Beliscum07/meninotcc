import 'package:flutter/material.dart';

class AdminBolsas extends StatelessWidget {
  const AdminBolsas({super.key});

  static const Color primaryColor = Color(0xFF565A9A);
  static const Color accentColor = Color(0xFFC56BE0);
  static const Color backgroundColor = Color(0xFFF5F1EA);

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

                    const SizedBox(height: 24),

                    _buildScholarshipCard(
                      title: 'Bolsa Educação\nIntegral',
                      description:
                          'Apoio completo para educação e material escolar.',
                      beneficiaries: '25',
                      monthlyValue: 'R\$ 300',
                      investment: 'R\$ 7.500',
                    ),

                    const SizedBox(height: 16),

                    _buildScholarshipCard(
                      title: 'Bolsa Esporte e Cultura',
                      description:
                          'Auxílio para atividades esportivas e culturais.',
                      beneficiaries: '15',
                      monthlyValue: 'R\$ 150',
                      investment: 'R\$ 2.250',
                    ),

                    const SizedBox(height: 16),

                    _buildScholarshipCard(
                      title: 'Bolsa Alimentação',
                      description:
                          'Auxílio para alimentação dos beneficiários.',
                      beneficiaries: '40',
                      monthlyValue: 'R\$ 200',
                      investment: 'R\$ 8.000',
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // CABEÇALHO
  // =========================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      color: primaryColor,
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
            onPressed: () {
              // Futuramente: cadastrar nova bolsa
            },
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

  // =========================
  // CARDS DE RESUMO
  // =========================

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            icon: Icons.people_outline,
            title: 'Beneficiados',
            value: '80',
            iconColor: accentColor,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _buildSummaryCard(
            icon: Icons.attach_money,
            title: 'Total/Mês',
            value: 'R\$ 17.8k',
            iconColor: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 22,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            style: TextStyle(
              color: primaryColor,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // CARD DA BOLSA
  // =========================

  Widget _buildScholarshipCard({
    required String title,
    required String description,
    required String beneficiaries,
    required String monthlyValue,
    required String investment,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
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
                    colors: [
                      Color(0xFFB96DD9),
                      Color(0xFF565A9A),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.workspace_premium_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF303747),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDF1E5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Ativo',
                            style: TextStyle(
                              color: Color(0xFF39835A),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 15,
                        height: 1.3,
                      ),
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
                child: _buildInfoBox(
                  title: 'Beneficiários',
                  value: beneficiaries,
                  valueColor: primaryColor,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _buildInfoBox(
                  title: 'Valor Mensal',
                  value: monthlyValue,
                  valueColor: accentColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Divider(
            color: Colors.grey.shade300,
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              const Text(
                'Investimento mensal:',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF555D6D),
                ),
              ),

              const SizedBox(width: 5),

              Text(
                investment,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF555D6D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================
  // CAIXAS DE INFORMAÇÃO
  // =========================

  Widget _buildInfoBox({
    required String title,
    required String value,
    required Color valueColor,
  }) {
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
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // DECORAÇÃO PADRÃO
  // =========================

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFFFDFDFD),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: const Color(0xFFD9D9D9),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}