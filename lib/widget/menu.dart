import 'package:flutter/material.dart';
import '../firebase.service.dart';
import 'rc_menu.dart';

class Menu extends StatefulWidget {
  final Function(String?) onFolderSelected;
  const Menu({super.key, required this.onFolderSelected});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Stream<List<Map<String, dynamic>>> foldersStream;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    foldersStream = FirebaseService.getFoldersStream();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Ink(
        color: const Color(0xFF252526),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.notes, color: Colors.white),
              title: const Text('Notes', style: TextStyle(color: Colors.white)),
              tileColor: const Color.fromARGB(255, 138, 23, 23),
              onTap: () {
                widget.onFolderSelected(null);
              },
            ),
            GestureDetector(
              onSecondaryTapDown: (TapDownDetails details) {
                showCustomMenu(context, details.globalPosition, 'folders', '');
              },
              child: ListTile(
                leading:
                    const Icon(Icons.folder_copy_rounded, color: Colors.white),
                title: const Text('Folders',
                    style: TextStyle(color: Colors.white)),
                trailing: Icon(
                  isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                  color: Colors.white,
                ),
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
            ),
            if (isExpanded)
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: foldersStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const SizedBox.shrink();
                  } else {
                    return Expanded(
                      child: ListView(
                        children: snapshot.data!.map((folderData) {
                          return GestureDetector(
                            onSecondaryTapDown: (TapDownDetails details) {
                              showCustomMenu(context, details.globalPosition,
                                  'folder', folderData['id']);
                            },
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(left: 50),
                              leading: const Icon(Icons.folder_copy_rounded,
                                  color: Colors.white),
                              title: Text(folderData['name']),
                              onTap: () {
                                widget.onFolderSelected(folderData['id']);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
