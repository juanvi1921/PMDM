import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
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
                // Si el registro es exitoso, redirigimos al login
                Navigator.pushReplacementNamed(context, 'login');
              } else {
                // Si ocurre un error, mostramos el mensaje amigable
                _handleErrorMessage(errorMessage);
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

  // Esta función se encarga de mostrar mensajes amigables dependiendo del error
  void _handleErrorMessage(String errorMessage) {
    String message;

    switch (errorMessage) {
      case 'email-already-in-use':
        message = 'Este correo electrónico ya está en uso. Intenta con otro.';
        break;
      case 'weak-password':
        message = 'La contraseña es demasiado débil. Elige una contraseña más fuerte.';
        break;
      case 'invalid-email':
        message = 'El correo electrónico no es válido. Verifica e intenta de nuevo.';
        break;
      case 'network-request-failed':
        message = 'Error de conexión. Verifica tu red e intenta de nuevo.';
        break;
      default:
        message = 'Ocurrió un error desconocido. Intenta de nuevo más tarde.';
        break;
    }

    // Muestra el mensaje amigable usando el NotificationService
    NotificationService.showSnackbar(message);
  }
}
