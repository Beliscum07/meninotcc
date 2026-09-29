import 'package:flutter/material.dart';

class DoadorDoar extends StatefulWidget {
  const DoadorDoar({super.key});

  @override
  State<DoadorDoar> createState() => _DoadorDoarState();
}

class _DoadorDoarState extends State<DoadorDoar> {
  final TextEditingController _valorController = TextEditingController();

  double valorDoacao = 0.0;

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void atualizarValor(String valor) {
    String valorLimpo = valor.replaceAll(',', '.');

    setState(() {
      valorDoacao = double.tryParse(valorLimpo) ?? 0.0;
    });
  }

  String formatarValor(double valor) {
    return valor.toStringAsFixed(2).replaceAll('.', ',');
  }

  void mostrarQRCode() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('QR Code PIX'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.qr_code_2,
                size: 220,
                color: Colors.black,
              ),
              const SizedBox(height: 15),
              const Text(
                'Escaneie o QR Code para realizar a doação.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void copiarPix() {
    // Aqui você poderá colocar o Clipboard futuramente.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chave PIX copiada!'),
      ),
    );
  }

  void confirmarDoacao() {
    if (valorDoacao <= 0) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Doação de R\$ ${formatarValor(valorDoacao)} confirmada!',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBDD),

      appBar: AppBar(
        title: const Text(
          'Fazer Doação',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF5552A6),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // BANNER
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFD477E5),
                    Color(0xFF5754A8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Sua ajuda transforma vidas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Cada doação faz a diferença na vida de uma criança. '
                    'Obrigado por acreditar no nosso trabalho!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // =========================
            // PAGAMENTO PIX
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pagar com PIX',
                        style: TextStyle(
                          color: Color(0xFF5552A6),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Icon(
                        Icons.qr_code_2,
                        color: Colors.pinkAccent.shade100,
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Botão QR Code
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: OutlinedButton(
                      onPressed: mostrarQRCode,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF5552A6),
                        side: const BorderSide(
                          color: Color(0xFF5552A6),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Mostrar QR Code',
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Ou copie a chave PIX:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 38,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1EEF8),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: const Text(
                            'ong.criancas@example.com',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Container(
                        height: 38,
                        width: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD77AE5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: copiarPix,
                          icon: const Icon(
                            Icons.content_copy,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // =========================
            // AVISO
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1DDC8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFE5CDB3),
                ),
              ),
              child: const Text(
                'ℹ️ Após realizar a transferência PIX, clique no botão '
                '"Confirmar Doação" abaixo. Sua contribuição será registrada '
                'e você receberá uma confirmação por email.',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
