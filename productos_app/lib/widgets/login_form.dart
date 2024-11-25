import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:provider/provider.dart'; 

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            _buildEmailField(loginForm),
            const SizedBox(height: 20),
            _buildPasswordField(loginForm),
            const SizedBox(height: 30),
            LoginBtn(loginForm: loginForm),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField(LoginFormProvider loginForm) {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Correo Electrónico',
        icon: Icons.email,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) => loginForm.isValidEmail(value),
      onChanged: (value) => loginForm.email = value,
    );
  }

  Widget _buildPasswordField(LoginFormProvider loginForm) {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Contraseña',
        icon: Icons.lock_outline,
      ),
      obscureText: true,
      validator: (value) => loginForm.isValidPassword(value),
      onChanged: (value) => loginForm.password = value,
    );
  }
}
