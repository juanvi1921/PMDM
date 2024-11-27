import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/ui/input_decorations.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        decoration: _decorationDetails(),
        child: Form(
          key: productForm.formKey, // Conectar el formulario al FormKey
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Campo Nombre
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 30),
              // Campo Precio
              TextFormField(
                initialValue: '${product.price}',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}')), // Limitar a 2 decimales
                ],
                onChanged: (value) {
                  if (double.tryParse(value) != null) {
                    product.price = double.parse(value);
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: '150€',
                  labelText: 'Precio',
                ),
              ),
              const SizedBox(height: 30),
              // Switch de Disponibilidad
              SwitchListTile.adaptive(
                value: product.available,
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value) => productForm.updateAvailability(value), // Llamada a la función de ProductFormProvider
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _decorationDetails() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 5),
          blurRadius: 5,
        )
      ],
    );
  }
}
