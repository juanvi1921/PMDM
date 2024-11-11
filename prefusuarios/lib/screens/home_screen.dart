import 'package:flutter/material.dart';
import 'package:prefusuarios/widgets/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/'; //Ruta inicial
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias de usuario'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      drawer: const DrawerMenu(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Color secundario'),
          Divider(),
          Text('Génerero'),
          Divider(),
          Text('Nombre usuario'),
          Divider(), //Este Divider puede ser que toque quitarlo
        ],
      ),
    );
  }
}
