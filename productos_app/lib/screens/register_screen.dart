import 'package:flutter/material.dart';
import 'package:productos_app/widgets/register_form.dart';
import 'package:productos_app/widgets/widgets.dart'; // Importar el botón de Login

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              CardContainer(
                child: RegisterForm(), // Formulario de registro
              ),
            ],
          ),
        ),
      ),
    );
  }
}