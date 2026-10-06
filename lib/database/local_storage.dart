import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _usuarioKey = 'usuario_logado';
  static const String _doadorKey = 'doador_logado';

  static Future<void> salvarUsuarioLogado(Map<String, dynamic> usuario) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usuarioKey, jsonEncode(usuario));
  }

  static Future<void> salvarDoadorLogado(Map<String, dynamic> doador) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_doadorKey, jsonEncode(doador));
  }

  static Future<Map<String, dynamic>?> carregarUsuarioLogado() async {
    final prefs = await SharedPreferences.getInstance();
    final dados = prefs.getString(_usuarioKey);

    if (dados == null || dados.isEmpty) {
      return null;
    }

    return Map<String, dynamic>.from(jsonDecode(dados));
  }

  static Future<Map<String, dynamic>?> carregarDoadorLogado() async {
    final prefs = await SharedPreferences.getInstance();
    final dados = prefs.getString(_doadorKey);

    if (dados == null || dados.isEmpty) {
      return null;
    }

    return Map<String, dynamic>.from(jsonDecode(dados));
  }

  static Future<void> limparSessao() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usuarioKey);
    await prefs.remove(_doadorKey);
  }
}
