import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message, {Color? backgroundColor}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: backgroundColor ?? Colors.red, // Predeterminado en rojo
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
