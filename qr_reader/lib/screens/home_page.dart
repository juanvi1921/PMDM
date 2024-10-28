import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/addresses_page.dart';
import 'package:qr_reader/screens/maps_page.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        elevation: 0,
        actions: [
            Padding(padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.delete_forever)),)
        ],
      ),
      body: const _HomePageBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //Todo cuando la tarea cambiara
      bottomNavigationBar: CustomNavigatorbar(),
      floatingActionButton: ScanButton(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    
    switch (currentIndex) {
      case 0:
        return MapsPage();
      case 1:
        return AddressesPage();
      default:
        return MapsPage();
    }
  }
}
