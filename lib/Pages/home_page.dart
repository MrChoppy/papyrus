import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:papyrus/Pages/landing_page.dart';
import '../Firebase/firebase_folder.dart';
import '../Firebase/firebase_notes.dart';
import '../dialog/add_note_dialog.dart';
import '../Firebase/firebase.service.dart';
import '../widget/ghost_note_tile.dart';
import '../widget/menu.dart';
import '../widget/note_tile.dart';
import '../widget/rc_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? selectedFolder;

  void _onFolderSelected(Map<String, dynamic>? folder) {
    setState(() {
      selectedFolder = folder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF1F1F1F),
          fontFamily: 'ShantellSans',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color(0xFF1F1F1F)),
        ),
        home: GestureDetector(
            onSecondaryTapDown: (TapDownDetails details) {
              if (selectedFolder == null) {
                showCustomMenu(context, details.globalPosition, 'home', null);
              } else {
                showCustomMenu(
                    context, details.globalPosition, 'home', selectedFolder);
              }
            },
            child: Scaffold(
                appBar: AppBar(
                    title: const Text("Papyrus",
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: const Color(0xFF252526),
                    actions: [
                      IconButton(
                        icon:
                            const Icon(Icons.exit_to_app, color: Colors.white),
                        onPressed: () async {
                          await FirebaseService().signOut();
                          if (!context.mounted) return;
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const LandingPage(),
                          ));
                        },
                      ),
                    ]),
                body: Row(
                  children: <Widget>[
                    Menu(onFolderSelected: _onFolderSelected),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: StreamBuilder<List<Map<String, dynamic>>>(
                        stream: (selectedFolder == null)
                            ? FirebaseNote.getNotes()
                            : FirebaseFolder.getNotesInFolder(selectedFolder),
                        builder: (context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator(
                              color: Color(0xFF1F1F1F),
                            );
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
                                width: MediaQuery.of(context).size.width,
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
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: notes.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index < notes.length) {
                                            var note = notes[index];

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: NoteTile(
                                                note: note,
                                              ),
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
                ))));
  }
}
