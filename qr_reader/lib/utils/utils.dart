import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor; // Obtiene la URL del scan

  try {
    if (scan.tipo == 'http') {
      // Intenta lanzar la URL
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else if (scan.tipo == 'geo') {
      // Si el tipo es geo, navega a la página del mapa
      Navigator.pushNamed(context, 'map', arguments: scan);
    } else {
      throw Exception('Tipo de scan no reconocido');
    }
  } catch (e) {
    print('Error al intentar abrir la URL: $url, Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No se pudo abrir la URL: $url')),
    );
  }
}
