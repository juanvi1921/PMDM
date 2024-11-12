import 'package:flutter/material.dart';
import 'package:prefusuarios/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // Notifiers
  ValueNotifier<int> generoNotifier = ValueNotifier<int>(1);
  ValueNotifier<bool> colorSecundarioNotifier = ValueNotifier<bool>(false);
  ValueNotifier<String> nombreNotifier = ValueNotifier<String>('');

  // Getter y setter para la última página
  String get lastPage {
    return _prefs.getString('lastPage') ?? HomeScreen.routeName; // Por defecto, será la pantalla de inicio
  }

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }

  //GET y SET del genero
  int get genero {
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
    generoNotifier.value = value;
  }

//GET y SET del ColorSecundario
  bool get colorSecundario {
    // Si no existe el colorSecundario, devolverá un false
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs.setBool('colorSecundario', value);
    colorSecundarioNotifier.value = value;
  }

  //GET y SET del Nombre de usuario
  String get nombre {
    // Si no existe el nombreUsuario, devolverá una cadena vacía
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
    nombreNotifier.value = value;
  }
}
