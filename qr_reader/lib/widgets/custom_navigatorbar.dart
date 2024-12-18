import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigatorbar extends StatelessWidget {
  const CustomNavigatorbar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int i) => uiProvider.selectedMenuOpt = i,
        currentIndex: currentIndex,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.compass_calibration), label: 'Direcciones'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Tweets'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined), label: 'Instagram'),
          BottomNavigationBarItem(icon: Icon(Icons.telegram_outlined), label: 'Telegram')
        ]);
  }
}
