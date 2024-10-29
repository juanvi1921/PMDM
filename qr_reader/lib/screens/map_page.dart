import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)?.settings.arguments as ScanModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa', style: TextStyle(color: Colors.white),),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Text('Coordenadas: ${scan.valor}'),
      ),
    );
  }
}
