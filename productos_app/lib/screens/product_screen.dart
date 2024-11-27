import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/widgets/widgets.dart';

import '../services/services.dart';


class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Product? selectedProduct =
        ModalRoute.of(context)?.settings.arguments as Product?;

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(
        selectedProduct ??
            Product(
              id: null,
              name: '',
              price: 0.0,
              available: true,
              picture: null,
            ),
      ),
      child: _ProductScreenBody(),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm =
        Provider.of<ProductFormProvider>(context); // Acceso al provider
    final productsService =
        Provider.of<ProductsService>(context); // Acceso al ProductsService

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                    url: productForm
                        .product.picture), // Usar el producto del FormProvider
              ],
            ),
            const ProductForm(), // Formulario conectado al ProductFormProvider
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!productForm.isValidForm())
            return; // Validar el formulario antes de guardar

          await productsService.saveOrCreateProduct(productForm.product);
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.save_outlined,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
