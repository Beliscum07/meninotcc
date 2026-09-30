import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class GmailService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      gmail.GmailApi.gmailSendScope,
    ],
  );

  Future<void> enviarEmail({
    required String destinatario,
    required String assunto,
    required String corpoTexto,
  }) async {
    try {
      // 1. Solicita o login do usuário com a conta do Google
      final account = await _googleSignIn.signIn();
      if (account == null) {
        print('Login cancelado pelo usuário.');
        return;
      }

      // 2. Obtém o cliente HTTP autenticado
      final httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) {
        print('Falha ao obter cliente autenticado.');
        return;
      }

      // 3. Inicializa a API do Gmail
      final gmailApi = gmail.GmailApi(httpClient);

      // 4. Monta a mensagem no padrão RFC 2822
      final rawEmail = 'To: $destinatario\r\n'
          'Subject: $assunto\r\n'
          'Content-Type: text/plain; charset=utf-8\r\n\r\n'
          '$corpoTexto';

      // 5. Codifica o e-mail em Base64 URL-Safe
      final base64Email = base64UrlEncode(utf8.encode(rawEmail));
      final message = gmail.Message()..raw = base64Email;

      // 6. Envia o e-mail
      await gmailApi.users.messages.send(message, 'me');
      print('E-mail enviado com sucesso!');
    } catch (e) {
      print('Erro ao enviar e-mail via Gmail API: $e');
    }
  }
}