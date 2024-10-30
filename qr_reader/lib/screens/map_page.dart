import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    const CameraPosition initialPoint = CameraPosition(
      target: LatLng(38.5055343, -0.24057421725),
      zoom: 17,
    );
    return Scaffold(
      appBar: AppBar(title: Text('Mapa', style: TextStyle(color: Colors.white),), 
      elevation: 0,
      backgroundColor: Colors.deepPurple,
      iconTheme: const IconThemeData(color: Colors.white),),
  
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
