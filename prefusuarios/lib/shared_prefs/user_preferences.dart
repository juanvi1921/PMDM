import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  // ValueNotifiers
  ValueNotifier<int> generoNotifier = ValueNotifier<int>(1);
  ValueNotifier<bool> colorSecundarioNotifier = ValueNotifier<bool>(false);
  ValueNotifier<String> nombreNotifier = ValueNotifier<String>('');
  ValueNotifier<String> lastPageNotifier = ValueNotifier<String>('/');  // Aquí agregamos lastPageNotifier

  // Método de inicialización
  Future<void> initPrefs() async {
    // Cargar los datos desde el almacenamiento seguro
    String? genero = await _secureStorage.read(key: 'genero');
    String? colorSecundario = await _secureStorage.read(key: 'colorSecundario');
    String? nombre = await _secureStorage.read(key: 'nombre');
    String? lastPage = await _secureStorage.read(key: 'lastPage');  // Cargar la última página

    generoNotifier.value = int.tryParse(genero ?? '1') ?? 1;
    colorSecundarioNotifier.value = (colorSecundario ?? 'false') == 'true';
    nombreNotifier.value = nombre ?? '';
    lastPageNotifier.value = lastPage ?? '/';  // Establecemos la última página o la ruta raíz '/'
  }

  // Getter y Setter para género
  int get genero => generoNotifier.value;
  set genero(int value)  {
    _secureStorage.write(key: 'genero', value: value.toString());
    generoNotifier.value = value;
  }

  // Getter y Setter para color secundario
  bool get colorSecundario => colorSecundarioNotifier.value;
  set colorSecundario(bool value)  {
    _secureStorage.write(key: 'colorSecundario', value: value.toString());
    colorSecundarioNotifier.value = value;
  }

  // Getter y Setter para nombre
  String get nombre => nombreNotifier.value;
  set nombre(String value)  {
    _secureStorage.write(key: 'nombre', value: value);
    nombreNotifier.value = value;
  }

  // Getter y Setter para la última página
  String get lastPage => lastPageNotifier.value;
  set lastPage(String value)  {
    _secureStorage.write(key: 'lastPage', value: value);
    lastPageNotifier.value = value;
  }
}
