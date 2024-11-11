import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

// Funciones para convertir entre JSON y ScanModel
ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  int? id;
  String? tipo;
  String valor;

  // Constructor con el parámetro 'valor' obligatorio
  ScanModel({
    this.id,
    required this.valor, // Usamos 'required' para indicar que es obligatorio
  }) : this.tipo =
            _determinaTipo(valor); //valor.contains('http') ? 'http' : 'geo';

  static String _determinaTipo(String valor) {
    if (valor.startsWith('https://www.instagram.com/') ||
        valor.startsWith('https://instagram.com/') ||
        valor.startsWith('http://instagram.com/') ||
        valor.startsWith('instagram.com/')) {
      return 'instagram';
    } else if (valor.startsWith('https://www.twitter.com/') ||
        valor.startsWith('https://twitter.com/') ||
        valor.startsWith('http://twitter.com/') ||
        valor.startsWith('twitter.com/')) {
      return 'tweets'; // Añadir soporte para Instagram
    } else if (valor.contains('http')) {
      return 'http'; // Añadir soporte para Tweets
    } else if (valor.startsWith('geo:')) {
      return 'geo';
    }
    return 'unknown'; // Tipo por defecto si no coincide con ningún caso
  }

  //Metodo getLang
  LatLng getLatLng() {
    final coordString =
        valor.substring(valor.indexOf(':') + 1); //saco la parte de coordenadas
    final coords =
        coordString.split(','); //Separo con split la latitud y la longitud
    final lat = double.parse(coords[0]); //Pasar a double
    final lng = double.parse(coords[1]);
    return LatLng(lat, lng);
  }

  // Factory para crear ScanModel desde JSON
  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        valor: json["valor"],
      );

  // Método para convertir ScanModel a JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
