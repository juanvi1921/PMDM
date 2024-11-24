import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:productos_app/providers/login_form_provider.dart'; // Importar el provider
import 'package:provider/provider.dart'; // Importar provider

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el provider directamente desde el contexto
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey, // Usar la formKey del provider
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            // Campo: Correo electrónico
            _buildEmailField(loginForm),
            const SizedBox(height: 20),

            // Campo: Contraseña
            _buildPasswordField(loginForm),
            const SizedBox(height: 30), // Espacio entre los campos y el botón

            // Botón de inicio de sesión, pasar loginForm como parámetro
            LoginBtn(loginForm: loginForm), // Pasamos loginForm al LoginBtn

            const SizedBox(
                height: 20), // Espacio entre el botón y el texto de registro

            // Aquí hemos eliminado el texto de "Crear cuenta" ya que lo manejamos con otro botón
          ],
        ),
      ),
    );
  }

  // Método para crear el campo de correo electrónico con validación
  Widget _buildEmailField(LoginFormProvider loginForm) {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Correo Electrónico',
        icon: Icons.email, // Icono de correo electrónico
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) =>
          loginForm.isValidEmail(value), // Usamos el método de validación
      onChanged: (value) => loginForm.email = value, // Asignamos al provider
    );
  }

  // Método para crear el campo de contraseña con validación
  Widget _buildPasswordField(LoginFormProvider loginForm) {
    return TextFormField(
      decoration: InputDecorations.authInputDecoration(
        labelText: 'Contraseña',
        icon: Icons.lock_outline, // Icono de contraseña
      ),
      obscureText: true,
      validator: (value) =>
          loginForm.isValidPassword(value), // Usamos el método de validación
      onChanged: (value) => loginForm.password = value, // Asignamos al provider
    );
  }
}
