import 'package:flutter/material.dart';

import '../Dashboard/DashboardScreen.dart';
import '../Dashboard/MainScreenForDashboard.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final String correctPassword = '12345'; // Düzgün şifrə

  void _checkPassword() {
    if (_passwordController.text == correctPassword) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Mainscreenfordashboard(),
        ),
      );    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Incorrect password'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Entry'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _passwordController,
                obscureText: true, // Şifrəni gizli göstərir
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkPassword,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
