import 'package:flutter/material.dart';
import 'package:prefusuarios/shared_prefs/user_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings'; // Ruta inicial
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final prefs = UserPreferences();
  bool _colorSecundario = false;
  late int _genero;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    prefs.initPrefs();
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _textController = TextEditingController(text: prefs.nombre);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // Método para cambiar el valor de género en las preferencias
  void _setSelectedRadio(int value) {
    setState(() {
      _genero = value;
      prefs.genero = value; // Guardar el valor en las preferencias
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: _colorSecundario ? Colors.teal : Colors.pink,
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
            value: _colorSecundario,
            title: const Text('Color secundario'),
            onChanged: (value) {
              setState(() {
                _colorSecundario = value;
                prefs.colorSecundario = value; // Guardar el valor en preferencias
              });
            },
          ),
          // Radio buttons para el género
          RadioListTile(
            value: 1,
            title: const Text('Masculino'),
            groupValue: _genero,
            onChanged: (value) {
              setState(() {
                _setSelectedRadio(value as int);
              });
            },
          ),
          RadioListTile(
            value: 2,
            title: const Text('Femenino'),
            groupValue: _genero,
            onChanged: (value) {
              setState(() {
                _setSelectedRadio(value as int);
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
                prefs.nombre = value; // Guardar el valor en preferencias
              },
            ),
          ),
        ],
      ),
    );
  }
}
