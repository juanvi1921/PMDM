import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/login_btn.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
              labelText: 'Correo Electrónico',
              icon: Icons.email,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => loginForm.isValidEmail(value),
            onChanged: (value) => loginForm.email = value,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
              labelText: 'Contraseña',
              icon: Icons.lock_outline,
            ),
            obscureText: true,
            validator: (value) => loginForm.isValidPassword(value),
            onChanged: (value) => loginForm.password = value,
          ),
          const SizedBox(height: 30),
          LoginBtn(loginForm: loginForm),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
