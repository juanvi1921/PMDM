import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/widgets/login_form.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

class RegisterBtn extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const RegisterBtn({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed:
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
          () async {
        // Validar el formulario primero
        if (formKey.currentState?.validate() ?? false) {
          // Ocultar el teclado
          FocusScope.of(context).unfocus();

          // Obtener el LoginFormProvider
          final loginForm =
              Provider.of<LoginFormProvider>(context, listen: false);

          // Obtener el servicio de autenticación
          final authService = Provider.of<AuthService>(context, listen: false);

          // Aquí puedes mostrar un indicador de carga si es necesario

          // Llamar al método para crear el usuario
          try {
            final String? errorMessage = await authService.createUser(
              loginForm.email,
              loginForm.password,
            );
            if (errorMessage == null) {
              Navigator.pushReplacementNamed(context, 'home');
            } else {
              print(errorMessage); // Muestra el error detallado
              print('ESTO ES UN ERROR');
            }
          } catch (e) {
            print('Error al crear el usuario: $e');
          }
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
