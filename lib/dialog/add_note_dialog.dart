import 'package:flutter/material.dart';

import '../firebase.service.dart';

class AddNoteDialog extends StatefulWidget {
  final String page;
  final Map<String, dynamic>? folder;
  const AddNoteDialog({super.key, required this.page, this.folder});

  @override
  _AddNoteDialogState createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF252526),
      surfaceTintColor: const Color(0xFF252526),
      title: const Text(
        'Add a Note',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              style: const TextStyle(
                color: Colors.white,
              ),
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Note Name',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                counterStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              maxLength: 15,
            ),
          ],
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
            String name = _nameController.text;
            if (widget.page == "home") {
              FirebaseService.addNote(name, "");
            } else if (widget.page == "folder") {
              FirebaseService.addNoteToFolder(
                  widget.folder!['id'], name, "", widget.folder!['name']);
            }
            Navigator.of(context).pop();
          },
          child: const Text(
            'Add',
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
