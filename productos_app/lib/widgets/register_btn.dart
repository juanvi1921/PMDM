import 'package:flutter/material.dart';
import 'package:productos_app/widgets/login_form.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

class RegisterBtn extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const RegisterBtn({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        /*loginForm.isLoading
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
                Navigator.pushReplacementNamed(context, 'home');
              } else {
                print(errorMessage);
                loginForm.isLoading = false;
              }
              */
        if (formKey.currentState?.validate() ?? false) {
          Future.delayed(const Duration(seconds: 2), () {
            print('Formulario de registro válido');
          });
        }
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
