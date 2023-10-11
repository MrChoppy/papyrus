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
      'folder': "",
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Stream<List<Map<String, dynamic>>> getNotes() {
    Query<Map<String, dynamic>> notes = FirebaseFirestore.instance
        .collection('notes')
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

  static Stream<List<Map<String, dynamic>>> getFoldersStream() {
    CollectionReference folders =
        FirebaseFirestore.instance.collection('folders');
    return folders.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
        };
      }).toList();
    });
  }

  static Stream<List<Map<String, dynamic>>> getNotesInFolder(
      Map<String, dynamic>? folder) {
    var notesCollection = FirebaseFirestore.instance
        .collection('folders')
        .doc(folder!['id'])
        .collection('notes')
        .orderBy('timestamp', descending: true)
        .snapshots();

    return notesCollection.map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();

        return {
          'id': doc.id,
          'name': data['name'] ?? '',
          'content': data['content'] ?? '',
          'folder': data['folder'] ?? '',
          'timestamp': data['timestamp'] ?? FieldValue.serverTimestamp(),
        };
      }).toList();
    }).handleError((e) {
      print("Error fetching notes: $e");
      return [];
    });
  }

  static Future<void> addFolder(String folderName) async {
    CollectionReference folders =
        FirebaseFirestore.instance.collection('folders');
    await folders.add({
      'name': folderName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> addNoteToFolder(
      String? folderId, String name, String content, String folder) async {
    //print(folderId);
    CollectionReference folderNotes = FirebaseFirestore.instance
        .collection('folders')
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
    // Get the reference to the note in the notes collection
    DocumentReference noteRef =
        FirebaseFirestore.instance.collection('notes').doc(noteId);
    DocumentSnapshot noteSnapshot = await noteRef.get();

    if (noteSnapshot.exists) {
      // Get note data
      Map<String, dynamic> noteData =
          noteSnapshot.data() as Map<String, dynamic>;

      // Create a new note document in the specified folder's notes collection
      CollectionReference folderNotes = FirebaseFirestore.instance
          .collection('folders')
          .doc(folderId)
          .collection('notes');

      // Add the note data to the folder's notes collection
      await folderNotes.add({
        'name': noteData['name'],
        'content': noteData['content'],
        'folder': noteData['folder'] ?? '',
        'timestamp': noteData['timestamp'] ?? FieldValue.serverTimestamp(),
      });

      await noteRef.delete();
    }
  }

  static Future<void> renameNote(String noteId, String newName) async {
    DocumentReference noteRef =
        FirebaseFirestore.instance.collection('notes').doc(noteId);

    await noteRef.update({
      'name': newName,
    });
  }

  static Future<void> renameFolder(String folderId, String newName) async {
    DocumentReference noteRef =
        FirebaseFirestore.instance.collection('folders').doc(folderId);

    await noteRef.update({
      'name': newName,
    });
  }

  static Future<void> renameNoteInFolder(
      String folderId, String noteId, String newName) async {
    //print(folderId);
    DocumentReference noteRef = FirebaseFirestore.instance
        .collection('folders')
        .doc(folderId)
        .collection('notes')
        .doc(noteId);

    await noteRef.update({
      'name': newName,
    });
  }

  static Future<void> deleteNote(String noteId) async {
    try {
      DocumentReference noteRef =
          FirebaseFirestore.instance.collection('notes').doc(noteId);

      await noteRef.delete();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }

  static Future<void> deleteNoteInFolder(String folderId, String noteId) async {
    try {
      DocumentReference noteRef = FirebaseFirestore.instance
          .collection('folders')
          .doc(folderId)
          .collection('notes')
          .doc(noteId);

      await noteRef.delete();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }

  static Future<List<Map<String, dynamic>>> getFolders() async {
    QuerySnapshot folderSnapshot =
        await FirebaseFirestore.instance.collection('folders').get();
    List<Map<String, dynamic>> foldersData = [];

    for (var doc in folderSnapshot.docs) {
      Map<String, dynamic> folderData = {
        'id': doc.id,
        'name': doc['name'],
        // Include other folder properties as needed
      };

      foldersData.add(folderData);
    }

    return foldersData;
  }
}
