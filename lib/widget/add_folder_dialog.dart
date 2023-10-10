import 'package:flutter/material.dart';
import 'package:papyrus/firebase.service.dart';

class AddFolderDialog extends StatefulWidget {
  const AddFolderDialog({super.key});

  @override
  _AddFolderDialogState createState() => _AddFolderDialogState();
}

class _AddFolderDialogState extends State<AddFolderDialog> {
  final TextEditingController _folderNameController = TextEditingController();

  @override
  void dispose() {
    _folderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Folder'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _folderNameController,
            decoration: const InputDecoration(labelText: 'Folder Name'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              String folderName = _folderNameController.text.trim();
              if (folderName.isNotEmpty) {
                await FirebaseService.addFolder(folderName);
                if (!context.mounted) return;
                Navigator.of(context).pop();
              } else {
                // Handle empty folder name error
              }
            },
            child: const Text('Create Folder'),
          ),
        ],
      ),
    );
  }
}
