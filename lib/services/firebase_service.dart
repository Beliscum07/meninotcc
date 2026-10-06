import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService instance = FirebaseService._();

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  Future<void> salvarUsuario({
    required String id,
    required String nome,
    required String email,
    required String senha,
    required String tipo,
  }) async {
    await firestore.collection('usuarios').doc(id).set({
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'tipo': tipo,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> salvarDoador({
    required String id,
    required String nome,
    required String email,
    required String senha,
    required String telefone,
    double totalDoado = 0,
  }) async {
    await firestore.collection('doadores').doc(id).set({
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'telefone': telefone,
      'totalDoado': totalDoado,
      'createdAt': FieldValue.serverTimestamp(),
    });
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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> listarUsuarios() async {
    final snapshot = await firestore.collection('usuarios').get();
    return snapshot.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> listarDoadores() async {
    final snapshot = await firestore.collection('doadores').get();
    return snapshot.docs;
  }
}
