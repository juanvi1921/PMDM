import 'package:flutter/material.dart';
import 'package:qr_reader/screens/addresses_page.dart';
import 'package:qr_reader/screens/home_page.dart';
import 'package:qr_reader/screens/instagram_post_page.dart';
import 'package:qr_reader/screens/map_page.dart';
import 'package:qr_reader/screens/tweets_page.dart';



Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'map': (BuildContext context) => MapPage(),
    'address': (BuildContext context) => AddressesPage(),
    'tweets': (BuildContext context) => TweetsPage(),
    'instagram': (BuildContext context) => InstagramPostsPage(),
    //'details': 
    //Este es otro metodo de llamar a las rutas.
    //AlertPage.pageName: (BuildContext context) => AlertPage()
  };
}