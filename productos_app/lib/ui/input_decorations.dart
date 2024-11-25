import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String labelText,
    IconData? icon,
    String? hintText,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: icon != null ? Icon(icon) : null,
      border: const OutlineInputBorder(),
    );
  }
}
