import 'package:flutter/material.dart';

class EditNoteDialog extends StatefulWidget {
  final Map<String, dynamic> note;
  final Function(String) onSave;

  const EditNoteDialog({
    Key? key,
    required this.onSave,
    required this.note,
  }) : super(key: key);

  @override
  _EditNoteDialogState createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note['content']);
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
          controller: _controller,
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
            widget.onSave(_controller.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
