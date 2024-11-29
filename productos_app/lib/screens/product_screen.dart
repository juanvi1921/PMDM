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
              fechaAlta: DateTime.now(),
            ),
      ),
      child: _ProductScreenBody(),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final productsService = Provider.of<ProductsService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productForm.product.picture,
                ),
              ],
            ),
            const ProductForm(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
        mainAxisAlignment: MainAxisAlignment.center, // Centra los botones
        children: [
          FloatingActionButton(
            heroTag: 'saveButton',
            onPressed: () async {
              if (!productForm.isValidForm()) return;

              await productsService.saveOrCreateProduct(productForm.product);
              Navigator.pop(context);
            },
            child: productsService.isSaving
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Icon(Icons.save_outlined, color: Colors.white),
          ),
          const SizedBox(width: 16), // Separación entre los botones
          if (productForm.product.id != null) // Mostrar el botón solo si el producto existe
            FloatingActionButton(
              heroTag: 'deleteButton',
              backgroundColor: Colors.red,
              onPressed: () async {
                final confirm = await _showDeleteConfirmationDialog(context);
                if (confirm == true) {
                  await productsService.deleteProduct(productForm.product.id!);
                  Navigator.pop(context);
                }
              },
              child: const Icon(Icons.delete_outline, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: const Text(
            '¿Estás seguro de que quieres eliminar este producto? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

