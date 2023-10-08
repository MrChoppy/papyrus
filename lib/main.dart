import 'dart:html';
import 'package:flutter/material.dart';
import 'package:papyrus/Pages/auth_page.dart';

void main() {
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papyrus',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 147, 120, 84),
        fontFamily: 'ShantellSans',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color.fromARGB(255, 147, 120, 84)),
      ),
      home: const LandingPage(),
    );
  }
}
