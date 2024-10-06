import 'package:flutter/material.dart';
  
final opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco'];
class HomePageTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Componentes Temp'),
        backgroundColor: Colors.pink,
      ),
      body: ListView(
        children: _crearItemsCorta()));
  }
  List<Widget> _crearItems() {
      List<Widget> listW = [];
      for (String opt in opciones) {
        final tempWidget = ListTile(
          title: Text(opt),
        );
        listW.add(tempWidget);
        listW.add(const Divider());
      }
      return listW;
    }
    
    List<Widget> _crearItemsCorta() {
      var widgets = opciones.map((item) {
        return Column(
          children: [
            ListTile(
              title: Text('$item!'),
              subtitle: const Text('Probando atributos'),
              leading: const Icon(Icons.accessible_sharp),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
            const Divider()
          ],
        );
      }).toList();
      return widgets;
    }
}