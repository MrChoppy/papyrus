import 'package:flutter/material.dart';

class GhostNoteTile extends StatelessWidget {
  const GhostNoteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey, // Ghost note color
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.add, color: Colors.white, size: 40.0), // Add icon
          SizedBox(height: 10.0),
          Text(
            'Add a New Note',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
