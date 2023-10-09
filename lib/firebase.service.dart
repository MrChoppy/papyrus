// firebase_service.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  static Future<void> addNote(String name, String content) async {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');
    await notes.add({
      'name': name,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Stream<QuerySnapshot> getNotesStream() {
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');
    return notes.snapshots();
  }
}
