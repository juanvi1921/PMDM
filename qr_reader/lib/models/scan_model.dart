import 'dart:convert';

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
  }) : this.tipo = valor.contains('http') ? 'http' : 'geo';

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
