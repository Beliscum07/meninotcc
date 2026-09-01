import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
           
            // CABEÇALHO
           

            Container(
              height: 51,
              width: double.infinity,
              color: const Color(0xFF5558AD),

              alignment: Alignment.centerLeft,

              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),

              child: const Text(
                'Configurações',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

           
            // CONTEÚDO
           

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 14),

                    // CARTÃO DO USUÁRIO

                    _cartaoUsuario(),

                    const SizedBox(height: 22),

                    // OPÇÕES

                    _opcoesConfiguracao(),

                    const SizedBox(height: 22),

                    // SOBRE O APP

                    _sobreApp(),

                    const SizedBox(height: 21),

                    // SAIR DA CONTA

                    _botaoSair(),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // CARTÃO DO USUÁRIO


  Widget _cartaoUsuario() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 0,
      ),

      width: double.infinity,

      height: 159,

      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(17),
          bottomRight: Radius.circular(17),
        ),

        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,

          colors: [
            Color(0xFFD778E8),
            Color(0xFF5558AD),
          ],
        ),

        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.only(
          left: 19,
          top: 22,
          right: 19,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                // Avatar
                Container(
                  width: 61,
                  height: 61,

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,

                    color: Color(0x55FFFFFF),
                  ),

                  alignment: Alignment.center,

                  child: const Text(
                    'M',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                // Nome e email
                const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Maria Silva',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      'admin@ong.com',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Administrador
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),

                borderRadius:
                    BorderRadius.circular(11),
              ),

              child: const Text(
                'Administrador',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // OPÇÕES DE CONFIGURAÇÃO


  Widget _opcoesConfiguracao() {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(15),

        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),

      child: Column(
        children: [
          _itemConfiguracao(
            icone: Icons.person_outline,
            titulo: 'Meu Perfil',
            onTap: () {},
          ),

          _divisor(),

          _itemConfiguracao(
            icone: Icons.notifications_none,
            titulo: 'Notificações',
            onTap: () {},
          ),

          _divisor(),

          _itemConfiguracao(
            icone: Icons.shield_outlined,
            titulo: 'Privacidade e Segurança',
            onTap: () {},
          ),

          _divisor(),

          _itemConfiguracao(
            icone: Icons.help_outline,
            titulo: 'Ajuda e Suporte',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ITEM DE CONFIGURAÇÃO


  Widget _itemConfiguracao({
    required IconData icone,
    required String titulo,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      child: SizedBox(
        height: 54,

        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
          ),

          child: Row(
            children: [
              Icon(
                icone,

                size: 21,

                color: const Color(0xFF5558AD),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Text(
                  titulo,

                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF222222),
                  ),
                ),
              ),

              const Text(
                '›',

                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF555555),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // DIVISOR


  Widget _divisor() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFE2E0EA),
    );
  }


  // SOBRE O APP


  Widget _sobreApp() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        16,
        19,
        16,
        18,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(15),

        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Text(
            'Sobre o App',

            style: TextStyle(
              color: Color(0xFF4F52A7),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Versão: 1.0.0',

            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF444444),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Desenvolvido para: ONG Apoio à Infância',

            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF444444),
            ),
          ),

          const SizedBox(height: 10),

          const Divider(
            height: 1,
            color: Color(0xFFE0DDE8),
          ),

          const SizedBox(height: 10),

          const Text(
            '© 2026 Todos os direitos reservados',

            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF444444),
            ),
          ),
        ],
      ),
    );
  }

  // BOTÃO SAIR
 

  Widget _botaoSair() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),

      child: SizedBox(
        width: double.infinity,
        height: 47,

        child: OutlinedButton.icon(
          onPressed: () {
            // Futuramente:
            // Navigator.pushReplacement(...)
          },

          icon: const Icon(
            Icons.logout,
            color: Colors.red,
            size: 20,
          ),

          label: const Text(
            'Sair da Conta',

            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
          ),

          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),

            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }

  
  // BARRA INFERIOR

  Widget _barraInferior() {
    return NavigationBar(
      height: 56,

      backgroundColor: Colors.white,

      selectedIndex: 4,

      indicatorColor: Colors.transparent,

      onDestinationSelected: (index) {
        // Aqui você vai colocar a navegação
        // entre as páginas.
      },

      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.grid_view_outlined,
          ),

          selectedIcon: Icon(
            Icons.grid_view,
          ),

          label: 'Dashboard',
        ),

        NavigationDestination(
          icon: Icon(
            Icons.people_outline,
          ),

          selectedIcon: Icon(
            Icons.people,
          ),

          label: 'Alunos',
        ),

        NavigationDestination(
          icon: Icon(
            Icons.calendar_month_outlined,
          ),

          selectedIcon: Icon(
            Icons.calendar_month,
          ),

          label: 'Atividades',
        ),

        NavigationDestination(
          icon: Icon(
            Icons.workspace_premium_outlined,
          ),

          selectedIcon: Icon(
            Icons.workspace_premium,
          ),

          label: 'Bolsas',
        ),

        NavigationDestination(
          icon: Icon(
            Icons.settings_outlined,
          ),

          selectedIcon: Icon(
            Icons.settings,
          ),

          label: 'Mais',
        ),
      ],
    );
  }
}