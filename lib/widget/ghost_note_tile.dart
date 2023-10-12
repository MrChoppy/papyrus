import 'package:flutter/material.dart';

class GhostNoteTile extends StatelessWidget {
  const GhostNoteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 200,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.add, color: Colors.white, size: 40.0),
          Text(
            'Add a New Note/Folder by right clicking',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
