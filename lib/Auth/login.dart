import 'package:flutter/material.dart';
import 'package:papyrus/Pages/home_page.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const SizedBox(
            width: 300,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Email',
                border:
                    OutlineInputBorder(), // Add border to the input decorator
                contentPadding:
                    EdgeInsets.all(10), // Adjust content padding as needed
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.mail, color: Color.fromARGB(255, 72, 58, 41)),
                  SizedBox(
                      width: 10), // Add spacing between icon and text field
                  Expanded(
                    child: TextField(
                      cursorColor: Color.fromARGB(255, 72, 58, 41),
                      decoration: InputDecoration(
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
          const SizedBox(
            width: 300,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Password',
                border:
                    OutlineInputBorder(), // Add border to the input decorator
                contentPadding: EdgeInsets.all(10),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.lock, color: Color.fromARGB(255, 72, 58, 41)),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      cursorColor: Color.fromARGB(255, 72, 58, 41),
                      obscureText: true,
                      decoration: InputDecoration(
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
            onPressed: () {
              // Handle login logic here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 147, 120, 84),
              backgroundColor: const Color.fromARGB(255, 72, 58, 41),
            ),
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
