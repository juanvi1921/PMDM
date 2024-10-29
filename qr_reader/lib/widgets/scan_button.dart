import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart'; // Importa el archivo de utilidades

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navega a la pantalla de escaneo
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QRScanScreen()),
        );
      },
      elevation: 0,
      child: const Icon(Icons.filter_center_focus, color: Colors.white,),
    );
  }
}

class QRScanScreen extends StatelessWidget {
  const QRScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Escanear código QR")),
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final String? code = barcode.rawValue;
            if (code != null) {
              print('Código escaneado: $code');

              // Crear un ScanModel para pasar a la función launchURL
              final scan = ScanModel(valor: code);

              //Guardar el escaneo
              final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
              scanListProvider.newScan(scan.valor);
              
              launchURL(context, scan); // Llama a launchURL en vez de _launchURL
              
              // Cierra el escáner después de un escaneo exitoso
              Navigator.pop(context); // Regresa a la pantalla anterior
              break; // Sal del bucle después de escanear el primer código
            }
          }
        },
      ),
    );
  }
}
