import 'package:flutter/material.dart';
import '../../../controllers/controller/auth_controller.dart';

class DoadorPerfil extends StatelessWidget {
  const DoadorPerfil({super.key});

  static final AuthController _auth = AuthController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _auth,
      builder: (context, _) {
        final doador = _auth.doadorLogado;
        final nome = doador?.nome ?? 'Doador';
        final email = doador?.email ?? 'doador@ong.com';
        final telefone = doador?.telefone ?? '';

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),

          appBar: AppBar(
            title: const Text(
              'Meu Perfil',
              style: TextStyle(fontWeight: FontWeight.bold),
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

                Text(
                  nome,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                Text(
                  email,
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),

                const SizedBox(height: 30),

                _informacao(
                  icone: Icons.person_outline,
                  titulo: 'Nome',
                  valor: nome,
                ),

                _informacao(
                  icone: Icons.email_outlined,
                  titulo: 'E-mail',
                  valor: email,
                ),

                _informacao(
                  icone: Icons.phone_outlined,
                  titulo: 'Telefone',
                  valor: telefone,
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,

                  child: OutlinedButton.icon(
                    onPressed: () => _editarPerfil(context),

                    icon: const Icon(Icons.edit_outlined),

                    label: const Text('Editar perfil'),

                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                ListTile(
                  onTap: () => _editarPerfil(context, editarSenha: true),
                  leading: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF5558AD),
                  ),
                  title: const Text('Editar e-mail / senha'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                ListTile(
                  onTap: () => _sair(context),
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Sair da conta',
                    style: TextStyle(color: Colors.red),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editarPerfil(BuildContext context, {bool editarSenha = false}) {
    final doador = _auth.doadorLogado;
    final nome = TextEditingController(text: doador?.nome ?? '');
    final email = TextEditingController(text: doador?.email ?? '');
    final telefone = TextEditingController(text: doador?.telefone ?? '');
    final senhaAtual = TextEditingController();
    final novaSenha = TextEditingController();
    final confirmarSenha = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(editarSenha ? 'Editar e-mail / senha' : 'Editar perfil'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nome,
                maxLength: 80,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: email,
                maxLength: 120,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              TextField(
                controller: telefone,
                maxLength: 20,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              if (editarSenha) ...[
                TextField(
                  controller: senhaAtual,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha atual'),
                ),
                TextField(
                  controller: novaSenha,
                  obscureText: true,
                  maxLength: 64,
                  decoration: const InputDecoration(
                    labelText: 'Nova senha (mín. 6)',
                  ),
                ),
                TextField(
                  controller: confirmarSenha,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar nova senha',
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              final emailValido = RegExp(
                r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
              ).hasMatch(email.text.trim());
              if (nome.text.trim().isEmpty ||
                  telefone.text.trim().isEmpty ||
                  !emailValido) {
                return;
              }
              if (editarSenha && novaSenha.text != confirmarSenha.text) {
                return;
              }
              final salvo = await _auth.atualizarDoadorPerfil(
                nome: nome.text,
                email: email.text,
                telefone: telefone.text,
                senhaAtual: editarSenha ? senhaAtual.text : null,
                novaSenha: editarSenha ? novaSenha.text : null,
              );
              if (!dialogContext.mounted) return;
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    salvo
                        ? 'Perfil atualizado.'
                        : 'Não foi possível atualizar. Confira a senha atual e o e-mail.',
                  ),
                ),
              );
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _sair(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Sair da conta?'),
        content: const Text('Você precisará fazer login novamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              await _auth.logout();
              if (!dialogContext.mounted) return;
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('Sair'),
          ),
        ],
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

        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),

      child: Row(
        children: [
          Icon(icone, color: const Color(0xFF5558AD)),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  titulo,

                  style: const TextStyle(fontSize: 12, color: Colors.black54),
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
