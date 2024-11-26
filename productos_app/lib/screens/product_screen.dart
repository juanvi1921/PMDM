import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(),
              ],
            ),
            ProductForm(),
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.save_outlined, color: Colors.white, size: 35,),
          //shape: const CircleBorder() Esto es si quisiera el boton de guardar redondo.
        ),
    );
  }
}