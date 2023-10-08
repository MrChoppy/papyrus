import 'package:flutter/material.dart';

class CustomPopupMenu {
  static const List<String> homePageChoices = [
    'Home Option 1',
    'Home Option 2'
  ];
  static const List<String> folderChoices = ['Rename', 'Delete'];
  static const List<String> noteChoices = ['Rename', 'Delete'];
}

void showCustomMenu(BuildContext context, Offset position, String page) async {
  List<String> menuItems = [];
  if (page == 'home') {
    menuItems = CustomPopupMenu.homePageChoices;
  } else if (page == 'folder') {
    menuItems = CustomPopupMenu.folderChoices;
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

  // Handle the selected choice here
  if (choice != null) {
    print('You selected: $choice');
  }
}
