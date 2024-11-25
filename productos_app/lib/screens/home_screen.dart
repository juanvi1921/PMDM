import 'package:flutter/material.dart';
import 'package:productos_app/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add, color: Colors.white,)),
    );
  }
}
