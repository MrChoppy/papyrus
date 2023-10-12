import 'package:flutter/material.dart';
import '../Firebase/firebase_folder.dart';

class DeleteFolderDialog extends StatelessWidget {
  final String folderId;

  const DeleteFolderDialog({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF252526),
      surfaceTintColor: const Color(0xFF252526),
      title: const Text(
        'Delete Note',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Deleting this folder will also delete all the notes in it.\nAre you sure you want to continue?',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (folderId != "") {
              FirebaseFolder.deleteFolder(folderId);
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            'Confirm',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
