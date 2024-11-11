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
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    Set<Marker> markers = new Set<Marker>();
      markers.add(new Marker(
        markerId: const MarkerId('geo-location'), position: scan.getLatLng()));
    CameraPosition initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(initialPoint));
            }, 
            icon: Icon(Icons.location_on, color: Colors.white,))
        ],
        title: const Text(
          'Mapa',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GoogleMap(
        mapType: mapType,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers, color: Colors.white,),
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }

          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
}
