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
          arguments: product, // Pasamos el producto seleccionado
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
            ProductDetails(
              title: product.name,
              subtitle: product.id.toString(),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: PriceTag(price: product.price),
            ),
            if (!product.available)
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 100,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: const FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'No disponible',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 9,
              right: 65,
              child: Text(
                _formatDate(product.fechaAlta),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Sin fecha';
    return '${date.day}/${date.month}/${date.year}';
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
        ),
      ],
    );
  }
}
