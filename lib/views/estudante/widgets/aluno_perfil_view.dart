import 'package:flutter/material.dart';

import '../../../services/aluno_data_service.dart';

class AlunoPerfilView extends StatefulWidget {
  final String alunoId;

  const AlunoPerfilView({
    super.key,
    this.alunoId = '001',
  });

  @override
  State<AlunoPerfilView> createState() =>
      _AlunoPerfilViewState();
}

class _AlunoPerfilViewState extends State<AlunoPerfilView> {
  // ==========================================================
  // CORES
  // ==========================================================

  static const Color roxo = Color(0xFF5056AC);
  static const Color rosa = Color(0xFFD277E2);
  static const Color fundo = Color(0xFFF5EADB);

  // ==========================================================
  // DADOS DO ALUNO
  // ==========================================================

  String nome = 'João Pedro Silva';
  String turma = '3A';

  String email = 'joao.pedro@ong.com';
  String telefone = '(11) 99876-5432';
  String endereco = 'Rua das Flores, 120';

  int atividades = 12;
  int presenca = 96;

  @override
  void initState() {
    super.initState();
    final aluno = AlunoDataService.instance.alunoPorId(widget.alunoId);
    nome = aluno?['nome']?.toString() ?? nome;
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,

      appBar: AppBar(
        backgroundColor: roxo,
        foregroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [

            // ------------------------------------------------
            // CABEÇALHO
            // ------------------------------------------------

            _buildCabecalho(),

            const SizedBox(height: 22),

            // ------------------------------------------------
            // ESTATÍSTICAS
            // ------------------------------------------------

            _buildEstatisticas(),

            const SizedBox(height: 22),

            ListenableBuilder(
              listenable: AlunoDataService.instance,
              builder: (context, child) {
                final aluno = AlunoDataService.instance.alunoPorId(
                  widget.alunoId,
                );
                final bolsas = (aluno?['bolsas'] as List?)
                        ?.whereType<String>()
                        .toList() ??
                    <String>[];

                return _buildBolsa(bolsas);
              },
            ),

            const SizedBox(height: 22),

            // ------------------------------------------------
            // DADOS DO ALUNO
            // ------------------------------------------------

            _buildDadosConta(),

            const SizedBox(height: 22),

            // ------------------------------------------------
            // AÇÕES
            // ------------------------------------------------

            _buildAcoes(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // CABEÇALHO DO PERFIL
  // ==========================================================

  Widget _buildCabecalho() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            rosa,
            roxo,
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

          // FOTO
          Container(
            width: 110,
            height: 110,

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.22),

              shape: BoxShape.circle,

              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),

            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 64,
            ),
          ),

          const SizedBox(height: 18),

          // NOME
          Text(
            nome,
            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // TURMA
          Text(
            'Aluno • Turma $turma',

            style: const TextStyle(
              color: Color(0xFFEDE7F8),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ESTATÍSTICAS
  // ==========================================================

  Widget _buildEstatisticas() {
    return Row(
      children: [

        Expanded(
          child: _estatistica(
            titulo: 'Atividades',
            valor: atividades.toString(),
            cor: rosa,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _estatistica(
            titulo: 'Presença',
            valor: '$presenca%',
            cor: roxo,
          ),
        ),
      ],
    );
  }

  Widget _buildBolsa(List<String> bolsas) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9E0F4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.workspace_premium_outlined,
                color: roxo,
              ),
              const SizedBox(width: 10),
              const Text(
                'Minhas bolsas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: roxo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (bolsas.isEmpty)
            const Text(
              'Nenhuma bolsa atribuída.',
              style: TextStyle(color: Colors.black54),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: bolsas.map((bolsa) {
                return Chip(
                  avatar: const Icon(
                    Icons.workspace_premium_outlined,
                    size: 18,
                  ),
                  label: Text(bolsa),
                  backgroundColor: const Color(0xFFF0EAF7),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  // ==========================================================
  // CARD DE ESTATÍSTICA
  // ==========================================================

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

  // ==========================================================
  // DADOS DA CONTA
  // ==========================================================

  Widget _buildDadosConta() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        border: Border.all(
          color: const Color(0xFFE9E0F4),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              const Expanded(
                child: Text(
                  'Dados da conta',

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: roxo,
                  ),
                ),
              ),

              IconButton(
                onPressed: _abrirEditarPerfil,

                icon: const Icon(
                  Icons.edit,
                  color: roxo,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _itemPerfil(
            icone: Icons.person_outline,
            titulo: 'Nome',
            valor: nome,
          ),

          _itemPerfil(
            icone: Icons.email_outlined,
            titulo: 'E-mail',
            valor: email,
          ),

          _itemPerfil(
            icone: Icons.phone_outlined,
            titulo: 'Telefone',
            valor: telefone,
          ),

          _itemPerfil(
            icone: Icons.location_on_outlined,
            titulo: 'Endereço',
            valor: endereco,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ITEM DO PERFIL
  // ==========================================================

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
              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: Icon(
              icone,
              color: roxo,
              size: 24,
            ),
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
                    fontSize: 15,
                    color: Color(0xFF666666),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  valor,

                  style: const TextStyle(
                    fontSize: 17,
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

  // ==========================================================
  // AÇÕES
  // ==========================================================

  Widget _buildAcoes() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            'Ações rápidas',

            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: roxo,
            ),
          ),

          const SizedBox(height: 12),

          _botaoAcao(
            icone: Icons.edit,
            texto: 'Editar perfil',
            onTap: _abrirEditarPerfil,
          ),

          _botaoAcao(
            icone: Icons.lock_outline,
            texto: 'Alterar senha',
            onTap: _alterarSenha,
          ),

          _botaoAcao(
            icone: Icons.logout,
            texto: 'Sair da conta',
            cor: Colors.red,
            onTap: _confirmarSaida,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // BOTÃO DE AÇÃO
  // ==========================================================

  Widget _botaoAcao({
    required IconData icone,
    required String texto,
    required VoidCallback onTap,
    Color cor = roxo,
  }) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(15),

      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),

        child: Row(
          children: [

            Icon(
              icone,
              color: cor,
              size: 26,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                texto,

                style: TextStyle(
                  fontSize: 17,
                  color: cor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: cor,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // EDITAR PERFIL
  // ==========================================================

  void _abrirEditarPerfil() {

    final nomeController =
        TextEditingController(text: nome);

    final emailController =
        TextEditingController(text: email);

    final telefoneController =
        TextEditingController(text: telefone);

    final enderecoController =
        TextEditingController(text: endereco);

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(
          title: const Text(
            'Editar perfil',
          ),

          content: SingleChildScrollView(
            child: Column(
              children: [

                TextField(
                  controller: nomeController,

                  decoration:
                      const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon:
                        Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: emailController,

                  decoration:
                      const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon:
                        Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller:
                      telefoneController,

                  decoration:
                      const InputDecoration(
                    labelText: 'Telefone',
                    prefixIcon:
                        Icon(Icons.phone),
                  ),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller:
                      enderecoController,

                  decoration:
                      const InputDecoration(
                    labelText: 'Endereço',
                    prefixIcon:
                        Icon(Icons.location_on),
                  ),
                ),
              ],
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

                setState(() {
                  nome =
                      nomeController.text;

                  email =
                      emailController.text;

                  telefone =
                      telefoneController.text;

                  endereco =
                      enderecoController.text;
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Perfil atualizado!',
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
  // ALTERAR SENHA
  // ==========================================================

  void _alterarSenha() {

    final senhaAtual =
        TextEditingController();

    final novaSenha =
        TextEditingController();

    final confirmarSenha =
        TextEditingController();

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(
          title: const Text(
            'Alterar senha',
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              TextField(
                controller: senhaAtual,

                obscureText: true,

                decoration:
                    const InputDecoration(
                  labelText: 'Senha atual',
                ),
              ),

              TextField(
                controller: novaSenha,

                obscureText: true,

                decoration:
                    const InputDecoration(
                  labelText: 'Nova senha',
                ),
              ),

              TextField(
                controller:
                    confirmarSenha,

                obscureText: true,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Confirmar nova senha',
                ),
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: () =>
                  Navigator.pop(context),

              child: const Text(
                'Cancelar',
              ),
            ),

            ElevatedButton(
              onPressed: () {

                if (novaSenha.text !=
                    confirmarSenha.text) {

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'As senhas não são iguais.',
                      ),
                    ),
                  );

                  return;
                }

                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Senha alterada!',
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
  // CONFIRMAR SAÍDA
  // ==========================================================

  void _confirmarSaida() {

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(
          title: const Text(
            'Sair da conta?',
          ),

          content: const Text(
            'Você precisará fazer login novamente.',
          ),

          actions: [

            TextButton(
              onPressed: () =>
                  Navigator.pop(context),

              child: const Text(
                'Cancelar',
              ),
            ),

            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              onPressed: () {

                Navigator.pop(context);

                // Aqui futuramente:
                //
                // Controller
                //    ↓
                // logout()
                //
                // Por enquanto apenas
                // voltamos para a tela anterior.

                Navigator.pop(context);
              },

              child: const Text(
                'Sair',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}