import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decorations.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        decoration: _decorationDetails(),
        child: Form(
          child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Nombre del producto',
                labelText: 'Nombre',
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '150€',
                labelText: 'Precio',
              ),
            ),
            const SizedBox(height: 30),
            SwitchListTile.adaptive(
              value: true, 
              title: const Text('Disponible'),
              activeColor: Colors.indigo,
              onChanged: (value) {
                //todo Por ahora no va nada
              }
            ),
          ],
        )),
      ),
    );
  }

  BoxDecoration _decorationDetails() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5),
            blurRadius: 5,
          )
        ]);
  }
}