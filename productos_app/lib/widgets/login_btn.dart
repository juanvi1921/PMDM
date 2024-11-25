import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';

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

              await Future.delayed(
                  const Duration(seconds: 2)); // Simulación de un retraso

              bool loginSuccessful =
                  false; // Aquí iría la lógica para comprobar el login

              if (loginSuccessful) {
                print('Login exitoso, navegar a la siguiente pantalla');
                // Aquí puedes redirigir a la pantalla siguiente
              } else {
                loginForm.isLoading =
                    false; // Volver a habilitar el botón si el login falla
                print('Login fallido, restauramos el botón');
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
          : Text(
              loginForm.isLoading
                  ? 'Espere'
                  : 'Acceder', // Cambiar el texto según el estado
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600, // Estilo de texto
                color: Colors.white,
              ),
            ),
    );
  }
}
