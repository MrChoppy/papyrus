import 'package:flutter/material.dart';
import 'package:papyrus/firebase.service.dart';

class RenameFolderDialog extends StatefulWidget {
  final Map<String, dynamic> folder;

  const RenameFolderDialog(
      {Key? key, required this.folder, required String page})
      : super(key: key);

  @override
  _RenameFolderDialogState createState() => _RenameFolderDialogState();
}

class _RenameFolderDialogState extends State<RenameFolderDialog> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.folder['name']);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF252526),
      surfaceTintColor: const Color(0xFF252526),
      title: const Text(
        'Rename Folder',
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
          hintText: 'Enter new folder name...',
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
            FirebaseService.renameFolder(widget.folder['id'], newName);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
