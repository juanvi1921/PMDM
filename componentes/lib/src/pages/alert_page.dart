import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Page'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Mostrar alerta'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue,
            shape: StadiumBorder()),
            onPressed: () => _mostrarAlert(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_location),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _mostrarAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Titulo'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Este es el contenido de la caja de alerta'),
              FlutterLogo(size: 70)
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(), 
              )
          ],
        );
      });
  }
}