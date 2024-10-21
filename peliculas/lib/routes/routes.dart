import 'package:flutter/material.dart';
import 'package:peliculas/screens/details_screen.dart';
import 'package:peliculas/screens/home_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomeScreen(),
    'details': (BuildContext context) => const DetailsScreen(),
    //Este es otro metodo de llamar a las rutas.
    //AlertPage.pageName: (BuildContext context) => AlertPage()
  };
}
