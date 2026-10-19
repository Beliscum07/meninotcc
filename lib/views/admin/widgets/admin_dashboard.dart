import 'dart:async';

import 'package:flutter/material.dart';

import '../../../generated/example.dart';
import '../../../services/auth_service.dart';
import '../../../services/sql_connect_service.dart';

class AdminDashboard extends StatefulWidget {
  final List<ListDonationsDoacoes>? doacoes;

  const AdminDashboard({super.key, this.doacoes});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  static const Color primaryColor = Color(0xFF565A9A);
  static const Color accentColor = Color(0xFFC56BE0);
  static const Color backgroundColor = Color(0xFFF5F1EA);

  final List<ListDonationsDoacoes> _doacoes = [];
  bool _carregando = false;
  Object? _erro;

  List<ListDonationsDoacoes> get doacoes => widget.doacoes ?? _doacoes;

  @override
  void initState() {
    super.initState();
    if (widget.doacoes == null) {
      _carregando = true;
      unawaited(_carregarDoacoes());
    }
  }

  Future<void> _carregarDoacoes() async {
    try {
      final registros = await SqlConnectService.instance.listarDoacoes();
      if (!mounted) return;
      setState(() {
        _doacoes
          ..clear()
          ..addAll(registros);
        _erro = null;
        _carregando = false;
      });
    } catch (error, stackTrace) {
      debugPrint('Falha ao carregar doações SQL: $error\n$stackTrace');
      if (mounted) {
        setState(() {
          _erro = error;
          _carregando = false;
        });
      }
    }
  }

  List<ListDonationsDoacoes> get _doacoesRecebidasNoMes {
    final agora = DateTime.now();
    return doacoes.where((doacao) {
      final data = doacao.data.toDateTime().toLocal();
      return doacao.status == 'recebida' &&
          data.year == agora.year &&
          data.month == agora.month;
    }).toList();
  }

  double get _totalRecebidoNoMes => _doacoesRecebidasNoMes.fold<double>(
    0,
    (total, doacao) => total + doacao.valor,
  );

  int get _doadoresNoMes => _doacoesRecebidasNoMes
      .map((doacao) => doacao.doador.usuario.email)
      .toSet()
      .length;

  List<double> get _totaisUltimosSeisMeses {
    final agora = DateTime.now();
    return List<double>.generate(6, (index) {
      final mes = DateTime(agora.year, agora.month - 5 + index);
      return doacoes
          .where((doacao) {
            final data = doacao.data.toDateTime().toLocal();
            return doacao.status == 'recebida' &&
                data.year == mes.year &&
                data.month == mes.month;
          })
          .fold<double>(0, (total, doacao) => total + doacao.valor);
    });
  }

  @override
  Widget build(BuildContext context) {
    final maiorValor = _totaisUltimosSeisMeses.fold<double>(
      0,
      (maior, valor) => valor > maior ? valor : maior,
    );

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _carregando
                  ? const Center(child: CircularProgressIndicator())
                  : _erro != null
                  ? _buildErro()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildSummaryCards(),
                          const SizedBox(height: 20),
                          _buildDonationChart(maiorValor),
                          const SizedBox(height: 20),
                          _buildRecentDonations(),
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
            onPressed: widget.doacoes == null
                ? () {
                    setState(() => _carregando = true);
                    unawaited(_carregarDoacoes());
                  }
                : null,
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Atualizar doações',
          ),
        ],
      ),
    );
  }

  Widget _buildErro() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Não foi possível carregar as doações.'),
          if (_erro != null) Text(AuthService.mensagemErro(_erro!)),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () {
              setState(() => _carregando = true);
              unawaited(_carregarDoacoes());
            },
            child: const Text('Tentar novamente'),
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
            titulo: 'Recebido no mês',
            valor: _dinheiro(_totalRecebidoNoMes),
            icone: Icons.attach_money,
            corIcone: accentColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            titulo: 'Doadores no mês',
            valor: '$_doadoresNoMes',
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

  Widget _buildDonationChart(double maiorValor) {
    final totais = _totaisUltimosSeisMeses;
    final agora = DateTime.now();
    final meses = List.generate(
      6,
      (index) => DateTime(agora.year, agora.month - 5 + index),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Doações recebidas nos últimos 6 meses',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(6, (index) {
                final valor = totais[index];
                final altura = maiorValor == 0 ? 4.0 : 110 * valor / maiorValor;
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: altura,
                        width: 22,
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_nomeMes(meses[index].month)),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Somente doações marcadas como recebidas.',
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentDonations() {
    final recentes = doacoes.take(10).toList();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Doações recentes',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          if (recentes.isEmpty)
            const Text('Ainda não há doações cadastradas.')
          else
            ...recentes.map(_buildDonationItem),
        ],
      ),
    );
  }

  Widget _buildDonationItem(ListDonationsDoacoes doacao) {
    final data = doacao.data.toDateTime().toLocal();
    const statuses = ['pendente', 'recebida', 'cancelada'];
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFF3E5F5),
        child: Icon(Icons.volunteer_activism, color: primaryColor),
      ),
      title: Text(doacao.doador.usuario.nome),
      subtitle: Text(
        '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} • ${doacao.metodo ?? 'Método não informado'}',
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _dinheiro(doacao.valor),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            value: statuses.contains(doacao.status)
                ? doacao.status
                : 'pendente',
            isDense: true,
            items: const [
              DropdownMenuItem(value: 'pendente', child: Text('Pendente')),
              DropdownMenuItem(value: 'recebida', child: Text('Recebida')),
              DropdownMenuItem(value: 'cancelada', child: Text('Cancelada')),
            ],
            onChanged: widget.doacoes != null
                ? null
                : (status) {
                    if (status != null) {
                      unawaited(_atualizarStatusDoacao(doacao, status));
                    }
                  },
          ),
        ],
      ),
    );
  }

  Future<void> _atualizarStatusDoacao(
    ListDonationsDoacoes doacao,
    String status,
  ) async {
    try {
      await SqlConnectService.instance.alterarStatusDoacao(
        id: doacao.id,
        status: status,
      );
      await _carregarDoacoes();
    } catch (error, stackTrace) {
      debugPrint('Falha ao atualizar status da doação: $error\n$stackTrace');
      if (mounted) setState(() => _erro = error);
    }
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFE3DDD4)),
    );
  }

  String _dinheiro(double valor) =>
      'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';

  String _nomeMes(int mes) => const [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez',
  ][mes - 1];
}
