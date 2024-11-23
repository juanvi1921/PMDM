import 'package:flutter/material.dart';
import 'package:productos_app/widgets/auth_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 250),
            Text(
              'LoginScreen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )),
    );
  }
}
