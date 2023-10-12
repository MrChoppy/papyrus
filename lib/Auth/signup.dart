import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Pages/home_page.dart';
import '../Firebase/firebase.service.dart';

class SignUp extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 300,
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Full Name',
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                border:
                    OutlineInputBorder(), // Add border to the input decorator
                contentPadding:
                    EdgeInsets.all(10), // Adjust content padding as needed
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.person,
                      color: Color.fromARGB(255, 255, 255, 255)),
                  const SizedBox(
                      width: 10), // Add spacing between icon and text field
                  Expanded(
                    child: TextField(
                      controller: fullNameController,
                      cursorColor: const Color.fromARGB(255, 255, 255, 255),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255)),
                      decoration: const InputDecoration(
                        border: InputBorder
                            .none, // Hide the border of the text field
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                border:
                    OutlineInputBorder(), // Add border to the input decorator
                contentPadding:
                    EdgeInsets.all(10), // Adjust content padding as needed
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.mail,
                      color: Color.fromARGB(255, 255, 255, 255)),
                  const SizedBox(
                      width: 10), // Add spacing between icon and text field
                  Expanded(
                    child: TextField(
                      controller: emailController,
                      cursorColor: const Color.fromARGB(255, 255, 255, 255),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255)),
                      decoration: const InputDecoration(
                        border: InputBorder
                            .none, // Hide the border of the text field
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle:
                    TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                border:
                    OutlineInputBorder(), // Add border to the input decorator
                contentPadding:
                    EdgeInsets.all(10), // Adjust content padding as needed
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.lock,
                      color: Color.fromARGB(255, 255, 255, 255)),
                  const SizedBox(
                      width: 10), // Add spacing between icon and text field
                  Expanded(
                    child: TextField(
                      controller: passwordController,
                      cursorColor: const Color.fromARGB(255, 255, 255, 255),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255)),
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              String fullName = fullNameController.text.trim();
              String email = emailController.text.trim();
              String password = passwordController.text.trim();
              if (fullName.isNotEmpty &&
                  email.isNotEmpty &&
                  password.isNotEmpty) {
                User? user = await firebaseService.registerWithEmailAndPassword(
                    email, password, fullName);

                if (user != null) {
                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } else {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to register. Please try again.'),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: const Color.fromARGB(255, 60, 60, 61),
            ),
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
