import 'package:flutter/material.dart';

class CustomNavigatorbar extends StatelessWidget {
  const CustomNavigatorbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map),
                                label: 'Mapa'),
        BottomNavigationBarItem(icon: Icon(Icons.compass_calibration),
                                label: 'Direcciones')
      ]);
  }
}