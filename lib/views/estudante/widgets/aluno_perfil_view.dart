import 'package:flutter/material.dart';

class AlunoPerfilView extends StatelessWidget {
  const AlunoPerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EADB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5056AC),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            // Topo do Perfil
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFD277E2),
                    Color(0xFF5056AC),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 64,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'João Pedro Silva',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Aluno • Turma 3A',
                    style: TextStyle(
                      color: Color(0xFFEDE7F8),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Estatísticas
            Row(
              children: [
                Expanded(
                  child: _estatistica(
                    titulo: 'Atividades',
                    valor: '12',
                    cor: const Color(0xFFE17BEA),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _estatistica(
                    titulo: 'Presença',
                    valor: '96%',
                    cor: const Color(0xFF5056AC),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // Dados da Conta
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE9E0F4)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dados da conta',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4047A5),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _itemPerfil(
                    icone: Icons.email_outlined,
                    titulo: 'E-mail',
                    valor: 'joao.pedro@ong.com',
                  ),
                  _itemPerfil(
                    icone: Icons.phone_outlined,
                    titulo: 'Telefone',
                    valor: '(11) 99876-5432',
                  ),
                  _itemPerfil(
                    icone: Icons.location_on_outlined,
                    titulo: 'Endereço',
                    valor: 'Rua das Flores, 120',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Ações Rápidas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ações rápidas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4047A5),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _acao(
                    icone: Icons.edit_note_outlined,
                    texto: 'Editar dados pessoais',
                  ),
                  _acao(
                    icone: Icons.settings_outlined,
                    texto: 'Configurações',
                  ),
                  _acao(
                    icone: Icons.logout,
                    texto: 'Sair da conta',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _estatistica({
    required String titulo,
    required String valor,
    required Color cor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            valor,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: cor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF555555),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemPerfil({
    required IconData icone,
    required String titulo,
    required String valor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFE9E0F4),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icone,
              color: const Color(0xFF5056AC),
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _acao({
    required IconData icone,
    required String texto,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icone,
            color: const Color(0xFF5056AC),
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              texto,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF333333),
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF5056AC),
          ),
        ],
      ),
    );
  }
}