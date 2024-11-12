import 'package:flutter/material.dart';
import 'package:prefusuarios/shared_prefs/user_preferences.dart';
import 'package:prefusuarios/widgets/drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/'; //Ruta inicial
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final prefs = UserPreferences();

  @override
  void initState() {
    super.initState();
    prefs.initPrefs();

    // Listener para actualizar el color de fondo cuando cambie colorSecundario
    prefs.colorSecundarioNotifier.addListener(() {
      setState(() {}); // Esto hace que se reconstruya el AppBar con el nuevo color
    });
  }

  @override
  void dispose() {
    // Quitar el listener para evitar problemas de memoria
    prefs.colorSecundarioNotifier.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias de usuario'),
        backgroundColor: prefs.colorSecundario ? Colors.teal : Colors.pink,
        foregroundColor: Colors.white,
      ),
      drawer: const DrawerMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: prefs.colorSecundarioNotifier,
            builder: (context, colorSecundario, child) {
              return Text('Color secundario: ${colorSecundario ? "Activado" : "Desactivado"}');
            },
          ),
          const Divider(),
          ValueListenableBuilder<int>(
            valueListenable: prefs.generoNotifier,
            builder: (context, genero, child) {
              return Text('Género: ${genero == 1 ? 'Masculino' : 'Femenino'}');
            },
          ),
          const Divider(),
          ValueListenableBuilder<String>(
            valueListenable: prefs.nombreNotifier,
            builder: (context, nombre, child) {
              return Text('Nombre usuario: $nombre');
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
