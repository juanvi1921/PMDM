import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ProductImage(),
            ],
          ),
          
        ],
      ),
    );
  }
}