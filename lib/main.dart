import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/auth/login_admin.dart';
import 'views/auth/login_doador.dart';
import 'views/auth/login_estudante.dart';

void main() {
  runApp(
    const ProviderScope(
      child: OngApp(),
    ),
  );
}

class OngApp extends StatelessWidget {
  const OngApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'ONG Apoio à Infância',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
      ),

      home: const TelaInicial(),
    );
  }
}

// ================================================================
// TELA INICIAL
// ================================================================

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB9A9D9),
              Color(0xFFEFE3DC),
            ],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),

              child: Column(
                children: [

                  // ==================================================
                  // LOGO
                  // ==================================================

                  const SizedBox(height: 18),

                  Container(
                    width: 166,
                    height: 166,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD969E8),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 88,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // ==================================================
                  // TÍTULO
                  // ==================================================

                  const Text(
                    'ONG Apoio à Infância',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Color(0xFF4F51A6),
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ==================================================
                  // SUBTÍTULO
                  // ==================================================

                  const Text(
                    'Transformando vidas através da educação,\ncultura e amor',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 25,
                      height: 1.35,
                    ),
                  ),

                  const SizedBox(height: 75),

                  // ==================================================
                  // ESTATÍSTICAS
                  // ==================================================

                  const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [
                      Estatistica(
                        icone: Icons.people_outline,
                        numero: '150+',
                        texto: 'Crianças atendidas',
                      ),

                      Estatistica(
                        icone: Icons.trending_up,
                        numero: '20+',
                        texto: 'Atividades',
                      ),

                      Estatistica(
                        icone: Icons.favorite_border,
                        numero: '500+',
                        texto: 'Doadores',
                      ),
                    ],
                  ),

                  const SizedBox(height: 80),

                  // ==================================================
                  // ACESSO ADMINISTRADOR
                  // ==================================================

                  BotaoAcesso(
                    texto: 'Acessar como Administrador',

                    cor: const Color(0xFFD969E8),

                    textoCor: Colors.white,

                    preenchido: true,

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AdminLoginPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // ACESSO ALUNO
                  // ==================================================

                  BotaoAcesso(
                    texto: 'Acessar como Aluno',

                    cor: const Color(0xFF5153AA),

                    textoCor: Colors.white,

                    preenchido: true,

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                              const LoginEstudantePage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // ACESSO DOADOR
                  // ==================================================

                  BotaoAcesso(
                    texto: 'Acessar como Doador',

                    cor: const Color(0xFF5153AA),

                    textoCor: const Color(0xFF5153AA),

                    preenchido: false,

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                              const LoginDoadorPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 150),

                  // ==================================================
                  // RODAPÉ
                  // ==================================================

                  const Text(
                    '© 2026 ONG Apoio à Infância',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [
                      Text(
                        'Feito com ',
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 20,
                        ),
                      ),

                      Icon(
                        Icons.favorite,
                        color: Color(0xFFFF3B81),
                        size: 25,
                      ),

                      Text(
                        ' para transformar vidas',
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// ESTATÍSTICA
// ================================================================

class Estatistica extends StatelessWidget {
  final IconData icone;
  final String numero;
  final String texto;

  const Estatistica({
    super.key,
    required this.icone,
    required this.numero,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [

          Container(
            width: 100,
            height: 100,

            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),

            child: Icon(
              icone,
              color: const Color(0xFF5558AD),
              size: 50,
            ),
          ),

          const SizedBox(height: 25),

          Text(
            numero,

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Color(0xFF4F51A6),
              fontSize: 43,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            texto,

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Color(0xFF555555),
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// BOTÃO DE ACESSO
// ================================================================

class BotaoAcesso extends StatelessWidget {
  final String texto;
  final Color cor;
  final Color textoCor;
  final bool preenchido;
  final VoidCallback onPressed;

  const BotaoAcesso({
    super.key,
    required this.texto,
    required this.cor,
    required this.textoCor,
    required this.preenchido,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 82,

      child: preenchido
          ? ElevatedButton(
              onPressed: onPressed,

              style: ElevatedButton.styleFrom(
                backgroundColor: cor,
                foregroundColor: textoCor,

                elevation: 4,

                shadowColor:
                    Colors.black.withOpacity(0.25),

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(22),
                ),
              ),

              child: Text(
                texto,

                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,

              style: OutlinedButton.styleFrom(
                foregroundColor: textoCor,

                backgroundColor:
                    Colors.transparent,

                side: BorderSide(
                  color: cor,
                  width: 3,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(22),
                ),
              ),

              child: Text(
                texto,

                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
    );
  }
}