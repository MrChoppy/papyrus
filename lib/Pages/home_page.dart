import 'dart:ui';

import 'package:flutter/material.dart';
import '../firebase.service.dart';
import '../widget/ghost_note_tile.dart';
import '../widget/menu.dart';
import '../widget/add_note_dialog.dart';
import '../widget/note_tile.dart';
import '../widget/rc_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedFolder;

  void _onFolderSelected(String? folderName) {
    setState(() {
      selectedFolder = folderName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF1F1F1F),
          fontFamily: 'ShantellSans',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color(0xFF1F1F1F)),
        ),
        home: GestureDetector(
            onSecondaryTapDown: (TapDownDetails details) {
              showCustomMenu(context, details.globalPosition, 'home', '');
            },
            child: Scaffold(
              body: Row(
                children: <Widget>[
                  Menu(onFolderSelected: _onFolderSelected),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: (selectedFolder == null)
                          ? FirebaseService
                              .getNotes() // Show all notes if no folder selected
                          : FirebaseService.getNotesInFolder(
                              selectedFolder!), // Show notes from selected folder
                      builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        List<Map<String, dynamic>> notes = snapshot.data!;
                        return Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Notes',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 160,
                              width: 3000,
                              child: ScrollConfiguration(
                                behavior:
                                    ScrollConfiguration.of(context).copyWith(
                                  dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  },
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    width: 3000,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: notes.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index < notes.length) {
                                          var note = notes[index];
                                          String name = note['name'] ?? '';
                                          String content =
                                              note['content'] ?? '';
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: NoteTile(
                                                name: name, content: content),
                                          );
                                        } else {
                                          return const GhostNoteTile();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AddNoteDialog(
                      page: 'home',
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            )));
  }
}
