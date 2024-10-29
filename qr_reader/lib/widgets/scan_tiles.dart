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
              leading: Icon(this.tipo == 'http' ? Icons.home_outlined : Icons.map_outlined, color: Theme.of(context).primaryColor),
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
}