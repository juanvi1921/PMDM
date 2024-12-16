import 'package:flutter/material.dart';
import 'package:productos_app/services/auth_service.dart';
import 'package:productos_app/widgets/register_form.dart';
import 'package:productos_app/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              CardContainer(
                child: RegisterForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
