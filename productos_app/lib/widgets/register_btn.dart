import 'package:flutter/material.dart';

class RegisterBtn extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const RegisterBtn({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          // Simula la espera de la respuesta del servidor
          Future.delayed(const Duration(seconds: 2), () {
            // Aquí puedes agregar la lógica para el registro
            // Si todo es exitoso, por ejemplo, navegar a otra pantalla
            print('Formulario de registro válido');
          });
        }
      },
      color: Colors.deepPurple,
      textColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
