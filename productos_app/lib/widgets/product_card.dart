import 'package:flutter/material.dart';
import 'package:productos_app/screens/product_screen.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProductScreen()));
      },
      child: Container(
        width: double.infinity,
        height: 400,
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        decoration: _cardBorders(),
        child: const Stack(
          alignment: Alignment.bottomLeft,
          children: [
            BackgroundImage(),
            ProductDetails(),
            Positioned(top: 0, right: 0, child: PriceTag()),
            Positioned(top: 0, left: 0, child: AvailableTag())
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
