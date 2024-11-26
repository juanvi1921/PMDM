import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5)),
            ]),
        child: Stack(children: [
          const Positioned.fill(
            child: const ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45)),
              child: FadeInImage(
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  image: NetworkImage(
                      'https://placehold.co/400x300/green/white.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
              iconSize: 40,
              color: Colors.white,
            ),
          ),
          Positioned(
              top: 60,
              right: 20,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt_outlined),
                iconSize: 40,
                color: Colors.white,
              ))
        ]),
      ),
    );
  }
}
