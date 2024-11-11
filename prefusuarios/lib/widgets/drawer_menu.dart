import 'package:flutter/material.dart';
import 'package:prefusuarios/screens/home_screen.dart';
import 'package:prefusuarios/screens/settings_screen.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/menu-img.jpg'),
                    fit: BoxFit.cover)),
          )),
          ListTile(
            leading: const Icon(Icons.pages, color: Colors.blue),
            title: const Text('Home'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, HomeScreen.routeName),
          ),
          ListTile(
              leading: const Icon(Icons.party_mode, color: Colors.blue),
              title: const Text('Party Mode'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.people, color: Colors.blue),
              title: const Text('People'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.settings, color: Colors.blue),
              title: const Text('Settings'),
              onTap: () {
                // Esto sería para si quisiéramos cerrar el menú
                // Navigator.pop(context);
                // Esta sería para si quisiéramos que no pudiera ya volver al menú
                // Navigator.pushReplacementNamed(context, SettingsScreen.routeName);
                // Esta sería par si quisiéramos darle la opción de que vuelva
                Navigator.pushNamed(context, SettingsScreen.routeName);
              }),
        ],
      ),
    );
  }
}
