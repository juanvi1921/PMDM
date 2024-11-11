import 'package:flutter/material.dart';
import 'package:prefusuarios/screens/home_screen.dart';
import 'package:prefusuarios/screens/settings_screen.dart';

void main() => runApp(const Preferencias());

class Preferencias extends StatelessWidget {
  const Preferencias({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferencias',
      debugShowCheckedModeBanner: false,
      
      initialRoute: HomeScreen.routeName,
      routes:  {
        HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
        SettingsScreen.routeName: (BuildContext context) => const SettingsScreen(),
        },
      theme: ThemeData(
          primarySwatch: Colors.pink,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.pink
          )
        ),
    );
  }
}