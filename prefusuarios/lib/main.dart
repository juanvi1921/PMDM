import 'package:flutter/material.dart';
import 'package:prefusuarios/screens/home_screen.dart';
import 'package:prefusuarios/screens/settings_screen.dart';
import 'package:prefusuarios/shared_prefs/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferences();
  await prefs.initPrefs();
  runApp(const Preferencias());
}

class Preferencias extends StatelessWidget {
  const Preferencias({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferencias',
      debugShowCheckedModeBanner: false,
      initialRoute: UserPreferences().lastPage, // Usamos la última página
      onGenerateRoute: (settings) {
        // Actualiza el 'lastPage' cuando se navegue a una nueva pantalla
        if (settings.name == SettingsScreen.routeName || settings.name == HomeScreen.routeName) {
          UserPreferences().lastPage = settings.name!; // Guardamos la ruta actual
        }

        // Retorna la ruta correspondiente
        switch (settings.name) {
          case HomeScreen.routeName:
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case SettingsScreen.routeName:
            return MaterialPageRoute(builder: (context) => const SettingsScreen());
          default:
            return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
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
