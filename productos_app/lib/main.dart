<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:productos_app/screens/login_screen.dart';
import 'package:productos_app/screens/home_screen.dart';
import 'package:productos_app/providers/login_form_provider.dart'; // Importa el LoginFormProvider
import 'package:provider/provider.dart'; // Importa el paquete provider

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(), // Proveemos LoginFormProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Productos App',
        initialRoute: 'login',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[300],
        ),
        routes: {
          'login': (context) => const LoginScreen(),
          'home': (context) => const HomeScreen(),
        },
        // Eliminamos home, porque ya estamos usando rutas
      ),
    );
  }
}
=======

>>>>>>> 8fa2d55f168327d5ac4d5ed56432f920762ea006
