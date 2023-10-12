import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Pages/home_page.dart';
import 'Pages/landing_page.dart';
import 'Firebase/firebase.service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.setPersistence(Persistence.NONE);

  window.document.onContextMenu.listen((evt) => evt.preventDefault());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Papyrus',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1F1F1F),
        fontFamily: 'ShantellSans',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF1F1F1F)),
      ),
      home: FutureBuilder<User?>(
        future: _firebaseService.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Color(0xFF1F1F1F),
            );
          } else {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const LandingPage();
            }
          }
        },
      ),
    );
  }
}
