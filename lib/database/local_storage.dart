import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _usuarioKey = 'usuario_logado';
  static const String _doadorKey = 'doador_logado';

  static Future<void> limparSessao() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usuarioKey);
    await prefs.remove(_doadorKey);
  }
}
