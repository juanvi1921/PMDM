import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
      child: const Icon(Icons.filter_center_focus),
    );
  }
}

class QRScanScreen extends StatelessWidget {
  const QRScanScreen({super.key});

  Future<void> _launchURL(BuildContext context, String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      print('No se pudo abrir la URL: $url');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir la URL: $url')),
      );
    }
  }

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
              _launchURL(context, Uri.encodeFull(code)); // Llama a _launchURL pasando context
              // Cierra el escáner después de un escaneo exitoso
              //Navigator.pop(context); // Regresa a la pantalla anterior
              break; // Sal del bucle después de escanear el primer código
            }
          }
        },
      ),
    );
  }
}