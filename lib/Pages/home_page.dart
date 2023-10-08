import 'package:flutter/material.dart';

import '../widgets/custom_menu.dart';
import '../widgets/folder.dart';
import '../widgets/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 147, 120, 84),
          fontFamily: 'ShantellSans',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color.fromARGB(255, 147, 120, 84)),
        ),
        home: GestureDetector(
          onSecondaryTapDown: (TapDownDetails details) {
            showCustomMenu(context, details.globalPosition, 'home');
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 30, top: 30),
                    child: Text(
                      'Folders',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 200, // Adjust the height according to your needs
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20.0),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          5, // Replace this with the number of folders you have
                      itemBuilder: (context, index) {
                        return const FolderWidget(
                            folderName: 'Work1', numberOfNotes: 10);
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30, top: 30),
                    child: Text(
                      'Notes',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 200, // Adjust the height according to your needs
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20.0),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          5, // Replace this with the number of notes you have
                      itemBuilder: (context, index) {
                        return NoteWidget(noteName: 'Noteaaaaaaaaaa $index');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
