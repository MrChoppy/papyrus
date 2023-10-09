import 'package:flutter/material.dart';

import '../firebase.service.dart';

class NoteDialog extends StatefulWidget {
  const NoteDialog({super.key});

  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a Note'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Note Name'),
              maxLength: 15,
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Note Content'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            String name = _nameController.text;
            String content = _contentController.text;

            FirebaseService.addNote(name, content);
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
