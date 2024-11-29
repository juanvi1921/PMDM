import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/providers/product_form_provider.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: productForm.formKey,
        child: Column(
          children: [
            const SizedBox(height: 15),
            // Campo para el nombre del producto
            TextFormField(
              initialValue: productForm.product.name,
              onChanged: (value) => productForm.product.name = value,
              decoration: const InputDecoration(
                labelText: 'Nombre del Producto',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            // Campo para el precio del producto
            TextFormField(
              initialValue: productForm.product.price.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  productForm.product.price = double.tryParse(value) ?? 0.0,
              decoration: const InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El precio es obligatorio';
                }
                if (double.tryParse(value) == null) {
                  return 'Debe ser un número';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            // Campo para la fecha de registro
            TextFormField(
              controller: TextEditingController(
                text: productForm.product.fechaAlta != null
                    ? _formatDate(productForm.product.fechaAlta!)
                    : '',
              ),
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Fecha de Registro',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: productForm.product.fechaAlta ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );

                if (selectedDate != null) {
                  productForm.product.fechaAlta = selectedDate;
                  productForm.notifyListeners();
                }
              },
            ),
            const SizedBox(height: 10),

            // Selector de Disponible/No Disponible
            SwitchListTile.adaptive(
              value: productForm.product.available,
              title: const Text('Disponible'),
              activeColor: Colors.indigo,
              onChanged: (value) => productForm.updateAvailability(value),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
