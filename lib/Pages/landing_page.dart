import 'package:flutter/material.dart';
import '../Auth/login.dart';
import '../Auth/signup.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isSignupSelected = false;

  void _toggleSwitch(bool value) {
    setState(() {
      isSignupSelected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch(
              value: isSignupSelected,
              onChanged: _toggleSwitch,
              activeColor: const Color.fromARGB(255, 255, 255, 255),
              inactiveThumbColor: const Color.fromARGB(255, 255, 255, 255),
              inactiveTrackColor: const Color.fromARGB(255, 60, 60, 61),
              activeTrackColor: const Color.fromARGB(255, 60, 60, 61),
              trackOutlineColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 60, 60, 61)),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              child: isSignupSelected ? SignUp() : Login(),
            ),
          ],
        ),
      ),
    );
  }
}
