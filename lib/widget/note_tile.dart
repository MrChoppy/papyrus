import 'package:flutter/material.dart';

import '/dialog/edit_note_dialog.dart';
import 'rc_menu.dart';

class NoteTile extends StatefulWidget {
  final Map<String, dynamic> note;

  const NoteTile({Key? key, required this.note}) : super(key: key);

  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    String name = widget.note['name'];
    String content = widget.note['content'];
    //String folder = widget.note['folder'];
    return GestureDetector(
      onSecondaryTapDown: (TapDownDetails details) {
        showCustomMenu(context, details.globalPosition, 'note', widget.note);
      },
      child: SizedBox(
        height: 150.0,
        width: 200,
        child: Material(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color(0xFF252526),
          child: ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditNoteDialog(
                      note: widget.note,
                    );
                  });
            },
            contentPadding: const EdgeInsets.all(8.0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.note, color: Colors.white, size: 40.0),
                Text(
                  'Name: $name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Content: ${content.length > 40 ? '${content.substring(0, 40)}...' : content}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
