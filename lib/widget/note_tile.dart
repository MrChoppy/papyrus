import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String name;
  final String content;

  NoteTile({required this.name, required this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      width: 200,
      child: Material(
        // Wrap your ListTile with Material widget
        borderRadius: BorderRadius.circular(12.0), // Set the border radius here
        color: Color.fromARGB(
            255, 1, 90, 255), // Set the background color to transparent
        child: ListTile(
          onTap: () {
            print("hey");
          },
          contentPadding:
              EdgeInsets.all(8.0), // Add some padding inside the ListTile
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
                'Content: $content',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          trailing: Icon(Icons.favorite_rounded),
        ),
      ),
    );
  }
}
