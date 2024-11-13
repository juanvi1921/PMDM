import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  AndroidOptions _secureOption() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  // Método para escribir datos en el almacenamiento seguro
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value, aOptions: _secureOption());
  }

  // Método para leer datos del almacenamiento seguro
  Future<String?> read(String key) async {
    return await _storage.read(key: key, aOptions: _secureOption());
  }

  // Método para eliminar un dato específico
  Future<void> delete(String key) async {
    await _storage.delete(key: key, aOptions: _secureOption());
  }

  // Método para eliminar todos los datos
  Future<void> deleteAll() async {
    await _storage.deleteAll(aOptions: _secureOption());
  }
}
