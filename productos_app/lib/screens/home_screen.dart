import 'package:flutter/material.dart';
import 'package:productos_app/services/products_service.dart';
import 'package:productos_app/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final producsService = Provider.of<ProductsService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ProductCard(),
            );
          }),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add, color: Colors.white, size: 35,),
          //shape: const CircleBorder() Esto es si quisiera el boton de + redondo.
        ),
    );
  }
}
