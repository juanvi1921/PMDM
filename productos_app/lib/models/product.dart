import 'dart:convert';

class Product {
  String? id;
  bool available;
  String name;
  String? picture;
  double price;

  // Constructor
  Product({
    this.id,
    required this.available,
    required this.name,
    this.picture,
    required this.price,
  });

  // Método toJson para convertir a un String JSON
  String toJson() => json.encode(toMap());

  // Factory constructor para crear un Product desde un JSON
  // Cambié el método para que no solo reciba un String, sino también un 'id' directamente
  factory Product.fromJson(String str, String id) => Product.fromMap(json.decode(str), id);

  // Factory constructor para crear un Product desde un mapa
  factory Product.fromMap(Map<String, dynamic> json, String id) => Product(
    id: id, // Se pasa el 'id' desde el contexto de Firebase
    available: json["available"],
    name: json["name"],
    picture: json["picture"],
    price: json["price"]?.toDouble(), // Asegurándonos que el precio sea double
  );

  // Convertir el Product a un mapa
  Map<String, dynamic> toMap() => {
    "available": available,
    "name": name,
    "picture": picture,
    "price": price,
  };

  // Método para crear una copia del producto
  Product copy() => Product(
    id: this.id, // Copiar el id también
    available: this.available,
    name: this.name,
    picture: this.picture,
    price: this.price, 
  );
}
