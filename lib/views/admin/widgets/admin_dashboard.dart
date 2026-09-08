
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  final Color primaryColor = const Color(0xFF565A9A);
  final Color accentColor = const Color(0xFFC56BE0);

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

  // =========================
  // DASHBOARD
  // =========================

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

  // =========================
  // CARDS SUPERIORES
  // =========================

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            title: 'Total do Mês',
            value: 'R\$ 12.500',
            icon: Icons.attach_money,
            subtitle: '↑ 15.3% vs mês anterior',
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

  // =========================
  // META MENSAL
  // =========================

  Widget _buildMonthlyGoal() {
    const double progress = 0.833;

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
                      'R\$ 12.500 / 15.000',
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
                  color: primaryColor.withOpacity(0.15),
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
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation(accentColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '83.3% da meta alcançada',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // GRÁFICO
  // =========================

  Widget _buildDonationChart() {
    final List<Map<String, dynamic>> months = [
      {'month': 'Dez', 'value': 0.60},
      {'month': 'Jan', 'value': 0.72},
      {'month': 'Fev', 'value': 0.65},
      {'month': 'Mar', 'value': 0.82},
      {'month': 'Abr', 'value': 1.0},
      {'month': 'Mai', 'value': 0.88},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.show_chart,
                color: primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Doações nos últimos 6 meses',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: months.map((data) {
                return _buildChartBar(
                  data['month'],
                  data['value'],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(String month, double value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 25,
          height: 120 * value,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          month,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // =========================
  // ÚLTIMAS DOAÇÕES
  // =========================

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

  // =========================
  // ESTILO PADRÃO DOS CARDS
  // =========================

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFFFDFDFD),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.grey.shade300,
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

