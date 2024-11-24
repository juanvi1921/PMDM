import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30), // Padding externo
      child: Container(
        padding: const EdgeInsets.all(20), // Padding interno
        width: double.infinity,
        decoration: createCardShape(),
        child: child, // El widget que se pase como parámetro
      ),
    );
  }

  BoxDecoration createCardShape() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}
