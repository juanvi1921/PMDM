import 'package:flutter/material.dart';
import 'package:qr_reader/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: '/',
      routes: getApplicationRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple
        )
      ),
    );
  }
}