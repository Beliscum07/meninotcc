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
      final account = await _googleSignIn.signIn();
      if (account == null) {
        throw Exception('Login cancelado pelo usuário.');
      }

      final httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) {
        throw Exception('Falha ao obter cliente autenticado.');
      }

      final gmailApi = gmail.GmailApi(httpClient);

      final rawEmail = 'To: $destinatario\r\n'
          'Subject: $assunto\r\n'
          'MIME-Version: 1.0\r\n'
          'Content-Type: text/plain; charset=utf-8\r\n\r\n'
          '$corpoTexto';

      final base64Email = base64Url.encode(utf8.encode(rawEmail)).replaceAll('=', '');
      final message = gmail.Message()..raw = base64Email;

      await gmailApi.users.messages.send(message, 'me');
      print('E-mail enviado com sucesso!');
    } on Exception catch (e) {
      print('Erro ao enviar e-mail via Gmail API: $e');
      rethrow;
    } catch (e) {
      print('Erro inesperado ao enviar e-mail: $e');
      rethrow;
    }
  }
}