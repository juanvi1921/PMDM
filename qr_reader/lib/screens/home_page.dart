import 'package:flutter/material.dart';
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
      body: MapsPage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //Todo cuando la tarea cambiara
      bottomNavigationBar: const CustomNavigatorbar(),
      floatingActionButton: const ScanButton(),
    );
  }
}
