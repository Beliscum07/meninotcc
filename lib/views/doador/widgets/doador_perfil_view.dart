import 'package:flutter/material.dart';

class DoadorPerfil extends StatelessWidget {
  const DoadorPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: const Color(0xFF5558AD),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            Container(
              width: 100,
              height: 100,

              decoration: const BoxDecoration(
                color: Color(0xFFC56BE0),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 55,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Doador',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'doador@ong.com',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            _informacao(
              icone: Icons.person_outline,
              titulo: 'Nome',
              valor: 'Doador Teste',
            ),

            _informacao(
              icone: Icons.email_outlined,
              titulo: 'E-mail',
              valor: 'doador@ong.com',
            ),

            _informacao(
              icone: Icons.phone_outlined,
              titulo: 'Telefone',
              valor: '(16) 99999-0000',
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: () {},

                icon: const Icon(
                  Icons.edit_outlined,
                ),

                label: const Text(
                  'Editar Perfil',
                ),

                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _informacao({
    required IconData icone,
    required String titulo,
    required String valor,
  }) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: const Color(0xFFE0E0E0),
        ),
      ),

      child: Row(
        children: [
          Icon(
            icone,
            color: const Color(0xFF5558AD),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  titulo,

                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  valor,

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}