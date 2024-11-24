import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  // Definimos los campos para el correo electrónico y la contraseña
  String _email = '';
  String _password = '';

  // Definimos una GlobalKey para el formulario
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Propiedad para controlar el estado de carga
  bool _isLoading = false;

  // Getters para acceder a los valores de los campos
  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;

  // Setters para actualizar los valores de los campos
  set email(String value) {
    _email = value;
    notifyListeners(); // Notificamos a los listeners cuando el valor cambia
  }

  set password(String value) {
    _password = value;
    notifyListeners(); // Notificamos a los listeners cuando el valor cambia
  }

  // Setter para actualizar el estado de carga
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Notificamos a los listeners cuando el valor cambia
  }

  // Método para validar los datos del formulario
  bool isValidForm() {
    // Validamos el formulario usando la formKey y el método validate()
    return formKey.currentState?.validate() ?? false;
  }

  // Método para validar el correo electrónico
  String? isValidEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo electrónico';
    }

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Por favor ingresa un correo electrónico válido';
    }
    return null; // Si es válido
  }

  // Método para validar la contraseña
  String? isValidPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña';
    } else if (value.length < 6) {
      return 'La contraseña debe contener al menos 6 caracteres';
    }
    return null; // Si es válido
  }
}
