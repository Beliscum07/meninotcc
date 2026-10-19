import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirestoreOperationException implements Exception {
  const FirestoreOperationException({
    required this.code,
    required this.message,
    required this.cause,
  });

  final String code;
  final String message;
  final FirebaseException cause;

  @override
  String toString() => 'FirestoreOperationException($code): $message';
}

class FirebaseService {
  FirebaseService._();

  static final FirebaseService instance = FirebaseService._();

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  Future<void> initialize() async {
    if (Firebase.apps.isNotEmpty) {
      return;
    }

    try {
      await Firebase.initializeApp();
    } catch (error, stackTrace) {
      debugPrint('FirebaseService.initialize falhou: $error');
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }

  Future<void> salvarUsuario({
    required String id,
    required String nome,
    required String email,
    required String tipo,
  }) async {
    await firestore.collection('usuarios').doc(id).set({
      'id': id,
      'nome': nome,
      'email': email,
      'tipo': tipo,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> salvarDoador({
    required String id,
    required String nome,
    required String email,
    required String telefone,
    double totalDoado = 0,
  }) async {
    await firestore.collection('doadores').doc(id).set({
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'totalDoado': totalDoado,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> incrementarCampo({
    required String caminhoDocumento,
    required String campo,
    required num valor,
  }) async {
    final caminho = caminhoDocumento.trim();
    final segmentosDocumento = caminho.split('/');
    if (caminho.isEmpty ||
        caminho != caminhoDocumento ||
        segmentosDocumento.length.isOdd ||
        segmentosDocumento.any((segmento) => segmento.isEmpty)) {
      throw ArgumentError.value(
        caminhoDocumento,
        'caminhoDocumento',
        'Informe o caminho completo de um documento existente.',
      );
    }
    if (campo.trim().isEmpty ||
        campo != campo.trim() ||
        campo.split('.').any((segmento) => segmento.isEmpty)) {
      throw ArgumentError.value(
        campo,
        'campo',
        'Informe um nome de campo válido.',
      );
    }
    if (!valor.isFinite) {
      throw ArgumentError.value(
        valor,
        'valor',
        'O incremento deve ser um número finito.',
      );
    }

    try {
      await firestore.doc(caminho).update({campo: FieldValue.increment(valor)});
    } on FirebaseException catch (error) {
      throw FirestoreOperationException(
        code: error.code,
        message: error.message ?? 'Falha ao incrementar o campo no Firestore.',
        cause: error,
      );
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> buscarUsuarioPorId(
    String id,
  ) async {
    return firestore.collection('usuarios').doc(id).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> buscarDoadorPorId(
    String id,
  ) async {
    return firestore.collection('doadores').doc(id).get();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  listarUsuarios() async {
    final snapshot = await firestore.collection('usuarios').get();
    return snapshot.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
  listarDoadores() async {
    final snapshot = await firestore.collection('doadores').get();
    return snapshot.docs;
  }
}
