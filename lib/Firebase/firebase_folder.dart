import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFolder {
  static Stream<List<Map<String, dynamic>>> getFoldersStream() {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    CollectionReference folders =
        FirebaseFirestore.instance.collection('users/$userId/folders');
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
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    var notesCollection = FirebaseFirestore.instance
        .collection('users/$userId/folders')
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
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    CollectionReference folders =
        FirebaseFirestore.instance.collection('users/$userId/folders');
    await folders.add({
      'name': folderName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> renameFolder(String folderId, String newName) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    DocumentReference noteRef = FirebaseFirestore.instance
        .collection('users/$userId/folders')
        .doc(folderId);

    await noteRef.update({
      'name': newName,
    });
  }

  static Future<List<Map<String, dynamic>>> getFolders() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    QuerySnapshot folderSnapshot = await FirebaseFirestore.instance
        .collection('users/$userId/folders')
        .get();
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

  static Future<void> deleteFolder(String folderId) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    try {
      DocumentReference folderRef = FirebaseFirestore.instance
          .collection('users/$userId/folders')
          .doc(folderId);

      await folderRef.delete();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }
}
