import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings'; //Ruta inicial
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _colorSecundario = false;
  int _genero = 1;
  String _nombre = 'Juan';
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _loadGenero();
    _textController = new TextEditingController(text: _nombre);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  //Metodo para cambiar el valor de genero
  void _setSelectedRadio(int value) async {
    setState(() {
      _genero = value;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('_genero', value);
  }

  //Cargar valor almacenado
  void _loadGenero() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _genero = prefs.getInt('_genero') ?? 1;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            child: const Text('Settings', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold)),
          ),
          const Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: const Text('Color secundario'),
            onChanged: (value) {
              setState(() {
                _colorSecundario = value;
              });
            }),
          RadioListTile(
            value: 1, 
            title: const Text('Masculino'),
            groupValue: _genero, 
            onChanged: (value) {
              setState(() {
                _setSelectedRadio(value as int);
              });
            }),
          RadioListTile(
            value: 2, 
            title: const Text('Femenino'),
            groupValue: _genero, 
            onChanged: (value) {
              setState(() {
                _setSelectedRadio(value as int);
              });
            }),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona utilizando el teléfono'),
            onChanged: (value) {
              setState(() {
                _nombre = value;
              });
            },
            ),
          )
        ],
      ), 
    );
  }
}