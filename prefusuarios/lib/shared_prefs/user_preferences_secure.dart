import 'package:flutter/material.dart';
import 'package:prefusuarios/flutter_secure_storage/secure_storage.dart';
import 'package:prefusuarios/screens/home_screen.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  final SecureStorage _storage = SecureStorage();

  factory UserPreferences() => _instance;

  UserPreferences._internal();

  // Notifiers
  ValueNotifier<int> generoNotifier = ValueNotifier<int>(1);
  ValueNotifier<bool> colorSecundarioNotifier = ValueNotifier<bool>(false);
  ValueNotifier<String> nombreNotifier = ValueNotifier<String>('');

  // Método de inicialización (ya no se necesita SharedPreferences)
  Future<void> initPrefs() async {
    // Carga los valores iniciales al iniciar la app
    generoNotifier.value = await getGenero();
    colorSecundarioNotifier.value = await getColorSecundario();
    nombreNotifier.value = await getNombre();
  }

  // Getter y setter para la última página
  Future<String> get lastPage async {
    return await _storage.read('lastPage') ?? HomeScreen.routeName;
  }

  Future<void> setLastPage(String value) async {
    await _storage.write('lastPage', value);
  }

  // Getter y setter del género
  Future<int> getGenero() async {
    final genero = await _storage.read('genero');
    return genero != null ? int.parse(genero) : 1;
  }

  Future<void> setGenero(int value) async {
    await _storage.write('genero', value.toString());
    generoNotifier.value = value;
  }

  // Getter y setter del color secundario
  Future<bool> getColorSecundario() async {
    final colorSecundario = await _storage.read('colorSecundario');
    return colorSecundario == 'true';
  }

  Future<void> setColorSecundario(bool value) async {
    await _storage.write('colorSecundario', value.toString());
    colorSecundarioNotifier.value = value;
  }

  // Getter y setter del nombre de usuario
  Future<String> getNombre() async {
    return await _storage.read('nombre') ?? '';
  }

  Future<void> setNombre(String value) async {
    await _storage.write('nombre', value);
    nombreNotifier.value = value;
  }
}
