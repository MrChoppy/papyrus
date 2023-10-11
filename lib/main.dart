import 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/Pages/home_page.dart';

import 'Pages/auth_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papyrus',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1F1F1F),
        fontFamily: 'ShantellSans',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF1F1F1F)),
      ),
      home: const HomeScreen(),
    );
  }
}
