import 'package:flutter/material.dart';
import 'package:qr_reader/screens/home_page.dart';



Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    //'details': 
    //Este es otro metodo de llamar a las rutas.
    //AlertPage.pageName: (BuildContext context) => AlertPage()
  };
}