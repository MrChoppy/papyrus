import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase.service.dart';
import '../widget/ghost_note_tile.dart';
import '../widget/note_dialog.dart';
import '../widget/note_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Papyrus'),
      ),
      body: Row(
        children: <Widget>[
          // View Options Section (Left Side)
          Container(
            width: 200, // Adjust the width as needed
            color: Colors.blue, // Set background color for view options
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Recent Notes',
                      style: TextStyle(color: Colors.white)),
                  tileColor: const Color.fromARGB(255, 138, 23, 23),
                  onTap: () {
                    // Handle Recent Notes action
                  },
                ),
                ListTile(
                  title: const Text('Folders',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Handle Folders action
                  },
                ),
                // Add more options as needed
              ],
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          // Main Content Section (Right Side)
          Expanded(
            child: StreamBuilder(
              stream: FirebaseService.getNotesStream(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                List<QueryDocumentSnapshot> notes = snapshot.data!.docs;
                return Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Notes',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      width: 3000,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 3000,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: notes.length + 1,
                              itemBuilder: (context, index) {
                                if (index < notes.length) {
                                  var note = notes[index];
                                  String name = note['name'] ?? '';
                                  String content = note['content'] ?? '';
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child:
                                        NoteTile(name: name, content: content),
                                  );
                                } else {
                                  return const GhostNoteTile();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
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
            builder: (context) => const NoteDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
