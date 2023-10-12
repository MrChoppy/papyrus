import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseNote {
  static Future<void> addNote(String name, String content) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    CollectionReference notes =
        FirebaseFirestore.instance.collection('users/$userId/notes');
    await notes.add({
      'name': name,
      'content': content,
      'folder': "",
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Stream<List<Map<String, dynamic>>> getNotes() {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    Query<Map<String, dynamic>> notes = FirebaseFirestore.instance
        .collection('users/$userId/notes')
        .orderBy('timestamp', descending: true);
    return notes.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'] ?? '',
          'content': doc['content'] ?? '',
          'folder': doc['folder'] ?? ''
        };
      }).toList();
    });
  }

  static Future<void> addNoteToFolder(
      String? folderId, String name, String content, String folder) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    CollectionReference folderNotes = FirebaseFirestore.instance
        .collection('users/$userId/folders')
        .doc(folderId)
        .collection('notes');

    await folderNotes.add({
      'name': name,
      'content': content,
      'folder': folderId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> moveNoteToFolder(String noteId, String folderId) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    DocumentReference noteRef = FirebaseFirestore.instance
        .collection('users/$userId/notes')
        .doc(noteId);
    DocumentSnapshot noteSnapshot = await noteRef.get();

    if (noteSnapshot.exists) {
      Map<String, dynamic> noteData =
          noteSnapshot.data() as Map<String, dynamic>;

      CollectionReference folderNotes = FirebaseFirestore.instance
          .collection('users/$userId/folders')
          .doc(folderId)
          .collection('notes');

      // Add the note data to the folder's notes collection
      await folderNotes.add({
        'name': noteData['name'],
        'content': noteData['content'],
        'folder': folderId,
        'timestamp': noteData['timestamp'] ?? FieldValue.serverTimestamp(),
      });

      await noteRef.delete();
    }
  }

  static Future<void> moveNoteToNotes(String noteId, String folderId) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    DocumentReference noteRef = FirebaseFirestore.instance
        .collection('users/$userId/folders/$folderId/notes')
        .doc(noteId);
    DocumentSnapshot noteSnapshot = await noteRef.get();

    if (noteSnapshot.exists) {
      Map<String, dynamic> noteData =
          noteSnapshot.data() as Map<String, dynamic>;

      CollectionReference folderNotes =
          FirebaseFirestore.instance.collection('users/$userId/notes');

      // Add the note data to the folder's notes collection
      await folderNotes.add({
        'name': noteData['name'],
        'content': noteData['content'],
        'folder': '',
        'timestamp': noteData['timestamp'] ?? FieldValue.serverTimestamp(),
      });

      await noteRef.delete();
    }
  }

  static Future<void> renameNote(String noteId, String newName) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    DocumentReference noteRef = FirebaseFirestore.instance
        .collection('users/$userId/notes')
        .doc(noteId);

    await noteRef.update({
      'name': newName,
    });
  }

  static Future<void> renameNoteInFolder(
      String folderId, String noteId, String newName) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    DocumentReference noteRef = FirebaseFirestore.instance
        .collection('users/$userId/folders')
        .doc(folderId)
        .collection('notes')
        .doc(noteId);

    await noteRef.update({
      'name': newName,
    });
  }

  static Future<void> editContentNote(String noteId, String newContent) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    DocumentReference noteRef = FirebaseFirestore.instance
        .collection('users/$userId/notes')
        .doc(noteId);

    await noteRef.update({
      'content': newContent,
    });
  }

  static Future<void> editContentNoteInFolder(
      String noteId, String newContent, String folderId) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    DocumentReference noteRef = FirebaseFirestore.instance
        .collection('users/$userId/folders/$folderId/notes')
        .doc(noteId);

    await noteRef.update({
      'content': newContent,
    });
  }

  static Future<void> deleteNote(String noteId) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    try {
      DocumentReference noteRef = FirebaseFirestore.instance
          .collection('users/$userId/notes')
          .doc(noteId);

      await noteRef.delete();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }

  static Future<void> deleteNoteInFolder(String folderId, String noteId) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    try {
      DocumentReference noteRef = FirebaseFirestore.instance
          .collection('users/$userId/folders')
          .doc(folderId)
          .collection('notes')
          .doc(noteId);

      await noteRef.delete();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }
}
