import 'package:flutter/material.dart';
import 'package:prefusuarios/shared_prefs/user_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings'; // Ruta inicial
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final prefs = UserPreferences(); // Instancia de UserPreferences
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    prefs.initPrefs(); // Inicializa las preferencias desde el almacenamiento seguro
    _textController = TextEditingController(text: prefs.nombre); // Setea el nombre en el controlador
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // Método para cambiar el valor de género en las preferencias
  void _setSelectedRadio(int value) {
    prefs.genero = value; // Establece el valor de genero usando el ValueNotifier
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: prefs.colorSecundario ? Colors.teal : Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            child: const Text(
              'Settings',
              style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          // Switch para el color secundario
          SwitchListTile(
            value: prefs.colorSecundario, // Usamos el valor del notifier
            title: const Text('Color secundario'),
            onChanged: (value) {
              setState(() {
                prefs.colorSecundario = value; // Guardamos el valor en secure storage
              });
            },
          ),
          // Radio buttons para el género
          RadioListTile(
            value: 1,
            title: const Text('Masculino'),
            groupValue: prefs.genero,
            onChanged: (value) {
              setState(() {
                _setSelectedRadio(value as int); // Cambiar género
              });
            },
          ),
          RadioListTile(
            value: 2,
            title: const Text('Femenino'),
            groupValue: prefs.genero,
            onChanged: (value) {
              setState(() {
                _setSelectedRadio(value as int); // Cambiar género
              });
            },
          ),
          const Divider(),
          // Campo de texto para el nombre de usuario
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona utilizando el teléfono',
              ),
              onChanged: (value) {
                prefs.nombre = value; // Guardar el valor en secure storage
              },
            ),
          ),
        ],
      ),
    );
  }
}
