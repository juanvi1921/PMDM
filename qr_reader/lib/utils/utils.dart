import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor; // Obtiene la URL del scan

  //Funcion para sacar el nombre de usuario
   String extractUsername(String url) {
      final uri = Uri.parse(url);
      return uri.pathSegments.last;
    }

  try {
    if (scan.tipo == 'http') {
      // Intenta lanzar la URL
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else if (scan.tipo == 'geo') {
      Future.delayed(const Duration(milliseconds: 300), () { //Sin los milliseconds se me queda en la pantalla del scanner pero con la camara cerrada
        Navigator.pushNamed(context, 'map', arguments: scan);
      });
    } else if (scan.tipo == 'tweets') {
      final twitterURL = "twitter://user?screen_name=${extractUsername(url)}";
      await launchUrlString(twitterURL);
    } else if (scan.tipo == 'instagram') {
      final instagramURL = "instagram://user?username=${extractUsername(url)}";
      await launchUrlString(instagramURL);
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
