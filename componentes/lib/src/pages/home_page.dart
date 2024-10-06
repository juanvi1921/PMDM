import 'package:componentes/src/providers/menu_providers.dart';
import 'package:flutter/material.dart';

import '../utils/icono_string_util.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Componentes'),
          backgroundColor: Colors.pink,
        ),
        body: _lista());
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        print('builder');
        print(snapshot.data);

        return ListView(
          children: _listaItems(snapshot.data ?? [], context),
        ); //Si snapshot.data es null que devuelva una lista vacia
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.pink),
        onTap: () {
          Navigator.pushNamed(context, opt['ruta']);
        },
      );
      opciones
        ..add(widgetTemp)
        ..add(const Divider());
    });
    return opciones;
  }
}
