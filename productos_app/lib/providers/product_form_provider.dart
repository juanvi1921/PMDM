import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  void updateAvailability(bool value) {
    product.available = value;
    notifyListeners(); // Notificar a los listeners para que la UI se actualice
  }

  void updateFechaAlta(DateTime date) {
    product.fechaAlta = date;
    notifyListeners();
  }

  bool isValidForm() {
    print(product.name);
    print(product.price);
    print(product.available);
    print('Fecha de Alta: ${product.fechaAlta}');
    return formKey.currentState?.validate() ?? false;
  }
}