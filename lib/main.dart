import 'package:flutter/material.dart';
import 'package:papyrus/Auth/landing_page.dart';

void main() {
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
        fontFamily: 'Roboto',
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
      ),
      home: const LandingPage(),
    );
  }
}
