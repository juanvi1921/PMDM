import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 300,
      decoration: _buildBoxDecoration(),
      child: const Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disco duro G',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5,),
            Text(
              'Id del disco duro',
              style: TextStyle(
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