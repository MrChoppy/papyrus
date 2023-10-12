import 'package:flutter/material.dart';
import 'package:papyrus/Firebase/firebase_notes.dart';

class EditNoteDialog extends StatefulWidget {
  final Map<String, dynamic> note;

  const EditNoteDialog({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  _EditNoteDialogState createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController(text: widget.note['content']);
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.note['name'];
    String content = widget.note['content'];

    return AlertDialog(
      backgroundColor: const Color(0xFF252526),
      surfaceTintColor: const Color(0xFF252526),
      title: Text(
        'Edit Note: $name',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      content: SizedBox(
        width: 1000,
        height: 1000,
        child: TextField(
          maxLines: null,
          onChanged: (value) {
            content = value;
          },
          style: const TextStyle(
            color: Colors.white,
          ),
          controller: contentController,
          decoration: const InputDecoration(
            labelText: 'Enter note content...',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
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
            if (widget.note['folder'] == "") {
              FirebaseNote.editContentNote(
                  widget.note['id'], contentController.text);
              Navigator.of(context).pop();
            } else if (widget.note['folder'] != "") {
              FirebaseNote.editContentNoteInFolder(widget.note['id'],
                  contentController.text, widget.note['folder']);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }
}
