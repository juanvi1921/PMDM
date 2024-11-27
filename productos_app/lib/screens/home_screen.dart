import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';
import 'package:productos_app/screens/loading_screen.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) {
      return const LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: productsService.products.length,
          itemBuilder: (context, index) {
            final product = productsService.products[index];
            return GestureDetector(
              onTap: () {
                  final product = productsService.products[index];
                  productsService.selectedProduct = product.copy(); 
                  Navigator.pushNamed(context, 'product');  
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ProductCard(product: product),
              ),
            );
          }),
      floatingActionButton:
          FloatingActionButton(onPressed: () {
            productsService.selectedProduct = new Product(
              available: false,
              name: "",
              price: 0,
            );
            Navigator.pushNamed(context, 'product');
          }, child: const Icon(Icons.add, color: Colors.white, size: 35,),
          //shape: const CircleBorder() Esto es si quisiera el boton de + redondo.
        ),
    );
  }
}
