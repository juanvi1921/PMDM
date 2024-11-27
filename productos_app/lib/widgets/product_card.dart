import 'package:flutter/material.dart';
import 'package:productos_app/models/product.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Enviar el producto como argumento al navegar
        Navigator.pushNamed(
          context,
          'product',
          arguments: product,  // Pasamos el producto seleccionado
        );
      },
      child: Container(
        width: double.infinity,
        height: 400,
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            BackgroundImage(product.picture),
            ProductDetails(title: product.name, subtitle: product.id.toString(),),
            Positioned(top: 0, right: 0, child: PriceTag(price: product.price,)),
            if (!product.available)
              const Positioned(top: 0, left: 0, child: AvailableTag()) //La clase se debe llamar NotAvailableTag
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 7),
            blurRadius: 10,
          )
        ]);
  }
}
