import 'package:flutter/material.dart';
import 'package:papyrus/firebase.service.dart';

class DeleteNoteDialog extends StatelessWidget {
  final String folderId;
  final String noteId;

  const DeleteNoteDialog(
      {super.key, required this.folderId, required this.noteId});

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
        'Are you sure you want to delete this note?',
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
            if (folderId == "") {
              FirebaseService.deleteNote(noteId);
              Navigator.of(context).pop();
            } else if (folderId != "") {
              FirebaseService.deleteNoteInFolder(folderId, noteId);
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
