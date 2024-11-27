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

  bool isValidForm() {
    print(product.name);
    print(product.price);
    print(product.available);
    return formKey.currentState?.validate() ?? false;
  }
}