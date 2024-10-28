import 'package:flutter/material.dart';
import 'package:qr_reader/screens/addresses_page.dart';
import 'package:qr_reader/screens/home_page.dart';
import 'package:qr_reader/screens/map_page.dart';



Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'map': (BuildContext context) => MapPage(),
    'address': (BuildContext context) => AddressesPage()
    //'details': 
    //Este es otro metodo de llamar a las rutas.
    //AlertPage.pageName: (BuildContext context) => AlertPage()
  };
}