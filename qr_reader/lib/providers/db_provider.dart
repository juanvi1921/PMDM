import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  static Database? _database;

  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database?> get dataBase async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    print("Database path: $path");
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans(
        id INTEGER PRIMARY KEY,
        tipo TEXT,
        valor TEXT
        ) 
      ''');
    });
  }

  Future<int?> nuevoScan(ScanModel nuevoScan) async {
    final db = await dataBase;
    final res = await db?.insert('Scans', nuevoScan.toJson());
    print(res);
    return res;
  }

//METODO PARA OBTENER UN REGISTRO POR SU ID
  Future<ScanModel?> getScanById(int id) async {
    final db = await dataBase;
    // Obtiene todos los registros (SELECT * from Scans)
    // final resAll = await db.query('Scans');
    // Obtiene el registro según un id
    final res = await db?.query('Scans', where: 'id = ?', whereArgs: [id]);
    // Obtiene el registro/s según varios parámetros
    //final resPorVarios = await db.query('Scans', where: 'id = ? and valor = ?', whereArgs: [id, valor]);
    // Si devuelve algún registro la consulta, lo pasamos a objeto Scan, sino null
    return res!.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

//METODOS PARA OBTENER UNA LISTA DE REGISTROS EL SEGUNDO FILTRANDO POR TIPOS
  Future<List<ScanModel>> getAllScans() async {
    final db = await dataBase;
    final res = await db?.query('Scans');
    return res!.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ScanModel>> getScansByTipo(String tipo) async {
    final db = await dataBase;

    // Aquí lo hacemos por el método raw, para probarlo
    final res = await db?.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    return res!.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

//METODO PARA ACTUALIZAR REGISTROS
  Future<int?> updateScan(ScanModel newScan) async {
    final db = await dataBase;
    final res = await db?.update('Scans', newScan.toJson(),
        where: 'id = ?', whereArgs: [newScan.id]);
    return res;
  }

//METODOS PARA BORRAR REGISTROS
  Future<int?> deleteScan(int id) async {
    final db = await dataBase;
    final res = await db?.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int?> deleteAllScans() async {
    final db = await dataBase;
    final res = await db?.delete('Scans');
    return res;
  }
}
