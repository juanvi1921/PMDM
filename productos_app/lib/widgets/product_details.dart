import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final String title;
  final String subtitle;
  const ProductDetails({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 300,
      decoration: _buildBoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5,),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white
              ),
            )
          ],
        ),
      )
    );
  }
}

BoxDecoration _buildBoxDecoration() {
  return const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      topRight: Radius.circular(25)
    )
  );
}