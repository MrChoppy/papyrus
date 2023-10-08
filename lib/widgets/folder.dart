import 'package:flutter/material.dart';
import 'custom_menu.dart';

class FolderWidget extends StatefulWidget {
  final String folderName;
  final int numberOfNotes;

  const FolderWidget({
    Key? key,
    required this.folderName,
    required this.numberOfNotes,
  }) : super(key: key);

  @override
  _FolderWidgetState createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    IconData folderIcon = _getFolderIcon(widget.folderName);

    return GestureDetector(
      onSecondaryTapDown: (TapDownDetails details) {
        showCustomMenu(context, details.globalPosition, 'folder');
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
                          255, 44, 27, 5) // Color when hovered
                      : const Color.fromARGB(255, 114, 86, 49),
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
                        folderIcon,
                        color: _isHovered
                            ? const Color.fromARGB(
                                255, 44, 27, 5) // Icon color when hovered
                            : const Color.fromARGB(255, 114, 86, 49),
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.folderName,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${widget.numberOfNotes} notes',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getFolderIcon(String folderName) {
    // Your icon mapping logic here
    return Icons.folder;
  }
}
