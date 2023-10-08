import 'package:flutter/material.dart';

import 'custom_menu.dart';

class NoteWidget extends StatefulWidget {
  final String noteName;
  @override
  _NoteWidgetState createState() => _NoteWidgetState();
  const NoteWidget({Key? key, required this.noteName}) : super(key: key);
}

class _NoteWidgetState extends State<NoteWidget> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onSecondaryTapDown: (TapDownDetails details) {
          showCustomMenu(context, details.globalPosition, 'note');
        },
        child: MouseRegion(
            onEnter: (_) {
              setState(() {
                _isHovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                _isHovered = false;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.all(15),
                    width: 125,
                    height: 120,
                    decoration: BoxDecoration(
                      color: _isHovered
                          ? const Color.fromARGB(
                              255, 100, 62, 12) // Color when hovered
                          : const Color.fromARGB(255, 139, 102, 54),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.note,
                            color: _isHovered
                                ? const Color.fromARGB(
                                    255, 100, 62, 12) // Color when hovered
                                : const Color.fromARGB(255, 139, 102, 54),
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                            height:
                                10), // Adjust the space between icon and text
                        Text(
                          widget.noteName,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
