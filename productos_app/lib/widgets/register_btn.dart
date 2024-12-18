import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/widgets/login_form.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

class RegisterBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return MaterialButton(
      onPressed:
          loginForm.isLoading
          ? null
          : () async {
              FocusScope.of(context).unfocus();
              final authService =
                  Provider.of<AuthService>(context, listen: false);

              if (!loginForm.isValidForm()) return;

              loginForm.isLoading = true;

              final String? errorMessage = await authService.createUser(
                  loginForm.email, loginForm.password);

              if (errorMessage == null) {
                Navigator.pushReplacementNamed(context, 'login'); //En el home no funciona
              } else {
                print(errorMessage);
                loginForm.isLoading = false;
              }
              print('email ${loginForm.email}');
              print('pass ${loginForm.password}');
          },
      color: Colors.deepPurple,
      textColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      minWidth: 220,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Text(
        'Registrarse',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
