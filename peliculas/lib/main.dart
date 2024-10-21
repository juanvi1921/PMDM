import 'package:flutter/material.dart';
import 'package:peliculas/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: getApplicationRoutes(),
      theme: ThemeData.light().copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
