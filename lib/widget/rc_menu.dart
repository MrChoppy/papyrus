import 'package:flutter/material.dart';
import 'package:papyrus/dialog/rename_note_dialog.dart';

import '../dialog/delete_note_dialog.dart';
import '/dialog/add_folder_dialog.dart';
import '/dialog/add_note_dialog.dart';

class CustomPopupMenu {
  static const List<String> homePageChoices = ['Add note'];
  static const List<String> folderChoices = [
    'Add note',
    'Rename',
    'Delete',
    'Open'
  ];
  static const List<String> foldersChoices = [
    'Add folder',
  ];
  static const List<String> noteChoices = ['Rename', 'Delete', 'Move'];
}

void showCustomMenu(BuildContext context, Offset position, String page,
    [Map<String, dynamic>? item]) async {
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
        builder: (context) => const AddFolderDialog(),
      );
    } else if (page == 'folder' && choice == 'Add note') {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AddNoteDialog(
          page: 'folder',
          folder: item,
        ),
      );
    } else if (page == 'home' && choice == 'Add note' && item == null) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AddNoteDialog(page: 'home', folder: item),
      );
    } else if (page == 'home' && choice == 'Add note' && item != null) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AddNoteDialog(page: 'folder', folder: item),
      );
    } else if (page == 'note' &&
        choice == 'Rename' &&
        item!['folder'] != null) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => RenameNoteDialog(
          page: 'note',
          note: item,
        ),
      );
    } else if (page == 'note' &&
        choice == 'Delete' &&
        item!['folder'] != null) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => DeleteNoteDialog(
          folderId: item['folder'],
          noteId: item['id'],
        ),
      );
    } else {
      // print('You selected: $choice');
    }
  }

  if (choice != null) {
    // print('You selected: $choice');
  }
}
