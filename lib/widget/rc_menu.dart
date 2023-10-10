import 'package:flutter/material.dart';

import 'add_folder_dialog.dart';
import 'add_note_dialog.dart';

class CustomPopupMenu {
  static const List<String> homePageChoices = ['Add note', 'Home Option 2'];
  static const List<String> folderChoices = [
    'Add note',
    'Rename',
    'Delete',
    'Open'
  ];
  static const List<String> foldersChoices = [
    'Add folder',
  ];
  static const List<String> noteChoices = ['Rename', 'Delete'];
}

void showCustomMenu(BuildContext context, Offset position, String page,
    String? folderId) async {
  List<String> menuItems = [];
  if (page == 'home') {
    menuItems = CustomPopupMenu.homePageChoices;
  } else if (page == 'folder') {
    menuItems = CustomPopupMenu.folderChoices;
  } else if (page == 'folders') {
    menuItems = CustomPopupMenu.foldersChoices;
  } else if (page == 'note') {
    menuItems = CustomPopupMenu.noteChoices;
  }

  String? choice = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
        position.dx, position.dy, position.dx, position.dy),
    items: menuItems.map((String choice) {
      return PopupMenuItem<String>(
        value: choice,
        child: Text(choice),
      );
    }).toList(),
  );

  if (choice != null) {
    if (page == 'folders' && choice == 'Add folder') {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) =>
            const AddFolderDialog(), // Create a new dialog for adding a folder
      );
    } else if (page == 'home' && choice == 'Add note') {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => const AddNoteDialog(
          page: 'home',
        ), // Create a new dialog for adding a folder
      );
    } else if (page == 'folder' && choice == 'Add note') {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AddNoteDialog(
          page: 'folder',
          folderId: folderId,
        ), // Create a new dialog for adding a folder
      );
    } else {
      print('You selected: $choice');
    }
  }

  // Handle the selected choice here
  if (choice != null) {
    print('You selected: $choice');
  }
}
