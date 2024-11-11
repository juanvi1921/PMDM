import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;
  const ScanTiles({super.key, required this.tipo});



  @override
  Widget build(BuildContext context) {
    return Consumer<ScanListProvider>(
      builder: (context, provider, child) {
        final scans = provider.scans;
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (_, i) => Dismissible(
            key: ValueKey(scans[i].id),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              //Eliminar el scan de la base de datos
              Provider.of<ScanListProvider>(context, listen: false).deleteScanById(scans[i].id!);
              
              //Eliminar de la lista el scan
              provider.scans.removeAt(i);

              //muestra un snackBar al eliminar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Eliminado correctamente')),
              );
            },
            child: ListTile(
              leading: _getIconWidget(scans[i].tipo),
              title: Text(scans[i].valor),
              subtitle: Text(scans[i].id.toString()),
              trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => launchURL(context, scans[i]),
            ),
          ),
        );
      },
    );
  }

 // Función para determinar el widget Icon
  Widget _getIconWidget(String? tipo) {
    // Verifica si el tipo es nulo antes de usarlo
    if (tipo == null) {
      return const Icon(Icons.help_outline); // Icono por defecto si el tipo es nulo
    }

    // Verifica el tipo
    if (tipo == 'http') {
      return const Icon(Icons.home_outlined); // Icono para 'http'
    } else if (tipo == 'geo') {
      return const Icon(Icons.map_outlined); // Icono para 'map'
    } else if (tipo == 'tweets') {
      return const Icon(Icons.chat); // Icono para 'tweets'
    } else if (tipo == 'instagram') {
      return const Icon(Icons.camera_alt_outlined); // Icono para 'instagram'
    }
    
    // Icono por defecto si no coincide con ninguno
    return const Icon(Icons.help_outline);
  }
}


