import 'package:flutter/material.dart';

import '../firebase.service.dart';

class AddNoteDialog extends StatefulWidget {
  final String page;
  final String? folderId;
  const AddNoteDialog({super.key, required this.page, this.folderId});

  @override
  _AddNoteDialogState createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
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

            if (widget.page == "home") {
              FirebaseService.addNote(name, content);
            } else if (widget.page == "folder") {
              FirebaseService.addNoteToFolder(widget.folderId, name, content);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
