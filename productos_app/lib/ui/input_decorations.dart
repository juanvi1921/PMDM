import 'package:flutter/material.dart';

class InputDecorations {
  // Método estático que devuelve un InputDecoration personalizado
  static InputDecoration authInputDecoration({
    required String labelText,
    IconData? icon, // Icono ahora es opcional
    String? hintText, // El hintText también es opcional
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText, // Puede ser null, y no se mostrará si no se pasa
      prefixIcon: icon != null
          ? Icon(icon)
          : null, // Solo muestra el icono si no es null
      border: const OutlineInputBorder(),
    );
  }
}
