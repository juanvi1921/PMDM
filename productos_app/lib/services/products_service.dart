import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ProductsService extends ChangeNotifier {
  File? newPictureFile;
  final String _baseUrl =
      'flutter-varios-be841-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Product> products = [];
  late Product selectedProduct = Product(
    id: '',
    name: '',
    price: 0.0,
    available: false,
    picture: null,
  );
  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    this.loadProducts();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodeData = resp.body;

    print(decodeData);

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    final decodeData = json.decode(resp.body);

    product.id = decodeData['name'];

    this.products.add(product);
    notifyListeners();

    print(decodeData);

    return '';
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    // Subir imagen si existe un archivo nuevo
    if (newPictureFile != null) {
        final imageUrl = await uploadImage(newPictureFile!.path);
        if (imageUrl != null) {
            product.picture = imageUrl;
        }
    }

    if (product.id == null) {
        await createProduct(product);
    } else {
        await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
}


  void updateSelectedProductImage(String path) { 
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage(String path) async {
    if(newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dchqrt0fd/image/upload?upload_preset=xsyldmjh');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Ha habido un error');
      print(resp.body);
      isSaving = false; // Asegurarse de que el indicador desaparezca en caso de error
      notifyListeners();
      return null;
    }

    newPictureFile = null;
    final decodedData = json.decode(resp.body);

    isSaving = false; // Actualizar el estado después de subir la imagen
    notifyListeners();
    return decodedData['secure_url'];
  }

  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = jsonDecode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value, key);
      tempProduct.id = key;
      this.products.add(tempProduct);
      print('Producto cargado: ${tempProduct.name}, ID: ${tempProduct.id}');
    });

    this.isLoading = false;
    notifyListeners();

    print(this.products[0].name);
    return this.products;
  }
}
