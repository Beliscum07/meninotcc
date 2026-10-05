import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _usuarioLogadoKey = 'usuario_logado';
  static const String _doadorLogadoKey = 'doador_logado';
  static const String _notificacoesLidasKey = 'notificacoes_lidas';

  static Future<void> salvarUsuarioLogado(Map<String, dynamic> usuario) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(usuario);
    await prefs.setString(_usuarioLogadoKey, json);
  }

  static Future<void> salvarDoadorLogado(Map<String, dynamic> doador) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(doador);
    await prefs.setString(_doadorLogadoKey, json);
  }

  static Future<Map<String, dynamic>?> carregarUsuarioLogado() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_usuarioLogadoKey);
    if (json == null || json.isEmpty) {
      return null;
    }

    return jsonDecode(json) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>?> carregarDoadorLogado() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_doadorLogadoKey);
    if (json == null || json.isEmpty) {
      return null;
    }

    return jsonDecode(json) as Map<String, dynamic>;
  }

  static Future<void> limparSessao() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usuarioLogadoKey);
    await prefs.remove(_doadorLogadoKey);
    await prefs.remove(_notificacoesLidasKey);
  }

  static Future<void> salvarNotificacoesLidas(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_notificacoesLidasKey, ids);
  }

  static Future<List<String>> carregarNotificacoesLidas() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_notificacoesLidasKey) ?? <String>[];
  }
}
