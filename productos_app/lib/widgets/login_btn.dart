import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';

class LoginBtn extends StatelessWidget {
  final LoginFormProvider loginForm; // Definir el parámetro loginForm

  const LoginBtn({Key? key, required this.loginForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: loginForm.isLoading
          ? null // Si está cargando, deshabilitamos el botón
          : () async {
              // Quitar el foco del teclado
              FocusScope.of(context).unfocus();

              // Desactivamos el botón y mostramos el indicador de carga
              loginForm.isLoading = true;

              // Simulamos una petición HTTP
              await Future.delayed(const Duration(seconds: 2));

              // Aquí puedes verificar la respuesta del backend (simulada)
              bool loginSuccessful =
                  false; // Cambiar según la lógica del backend

              if (loginSuccessful) {
                // Si el login es exitoso, procedemos a la siguiente pantalla
                print('Login exitoso, navegar a la siguiente pantalla');
              } else {
                // Si no es exitoso, restauramos el estado del botón
                loginForm.isLoading = false;
                print('Login fallido, restauramos el botón');
              }
            },
      color: Colors.deepPurple, // Color de fondo
      textColor: Colors.white, // Color del texto
      padding: const EdgeInsets.symmetric(
          vertical: 10.0), // Aumento de padding vertical
      minWidth: 220, // Asegura que el botón ocupe todo el ancho posible
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
                  : 'Acceder', // Cambiar el texto según el estado de carga
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600, // Estilo de texto
                color: Colors.white, // Color blanco para el texto
              ),
            ),
    );
  }
}
