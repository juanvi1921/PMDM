import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart'; // Asegúrate de importar el AuthService

class LoginBtn extends StatelessWidget {
  final LoginFormProvider loginForm;

  const LoginBtn({Key? key, required this.loginForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: loginForm.isLoading
          ? null // Si está cargando, deshabilitamos el botón
          : () async {
              // Primero, validamos el formulario
              if (!loginForm.isValidForm()) {
                // Si el formulario no es válido, no hacemos nada
                return;
              }

              // Si el formulario es válido, procedemos con el login
              FocusScope.of(context).unfocus(); // Ocultamos el teclado

              loginForm.isLoading = true; // Indicamos que estamos cargando

              final authService = Provider.of<AuthService>(context, listen: false);

              // Llamamos al método login
              final String? errorMessage = await authService.loginUser(
                loginForm.email,
                loginForm.password,
              );

              if (errorMessage == null) {
                // Si el login es exitoso, redirigimos al home o pantalla siguiente
                Navigator.pushReplacementNamed(context, 'home'); // O el nombre de la pantalla de inicio
              } else {
                // Si ocurre un error, mostramos el error y restauramos el estado del botón
                // Usamos NotificationService para mostrar el mensaje
                _handleErrorMessage(errorMessage);
                loginForm.isLoading = false;
              }
            },
      color: Colors.deepPurple, // Color de fondo
      textColor: Colors.white, // Color del texto
      padding: const EdgeInsets.symmetric(vertical: 10.0), // Padding vertical
      minWidth: 220, // Ancho más grande
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Borde redondeado
      ),
      child: loginForm.isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : const Text(
              'Acceder', // Texto del botón
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600, // Estilo de texto
                color: Colors.white,
              ),
            ),
    );
  }

  // Esta función se encarga de mostrar mensajes amigables dependiendo del error
  void _handleErrorMessage(String errorMessage) {
    String message;

    switch (errorMessage) {
      case 'wrong-password':
        message = 'La contraseña es incorrecta. Intenta nuevamente.';
        break;
      case 'user-not-found':
        message = 'No se encontró una cuenta con ese correo electrónico.';
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
