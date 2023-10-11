import 'package:flutter/material.dart';
import 'package:papyrus/firebase.service.dart';

class RenameNoteDialog extends StatefulWidget {
  final Map<String, dynamic> note;

  const RenameNoteDialog({Key? key, required this.note, required String page})
      : super(key: key);

  @override
  _RenameNoteDialogState createState() => _RenameNoteDialogState();
}

class _RenameNoteDialogState extends State<RenameNoteDialog> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.note['name']);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF252526),
      surfaceTintColor: const Color(0xFF252526),
      title: const Text(
        'Rename Note',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      content: TextField(
        controller: nameController,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Enter new note name...',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            String newName = nameController.text;

            if (widget.note['folder'] != "") {
              FirebaseService.renameNoteInFolder(
                  widget.note['folder'], widget.note['id'], newName);
            } else if (widget.note['folder'] == "") {
              FirebaseService.renameNote(widget.note['id'], newName);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
