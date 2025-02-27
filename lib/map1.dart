// map1.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen1 extends StatefulWidget {
  @override
  _MapScreen1State createState() => _MapScreen1State();
}

class _MapScreen1State extends State<MapScreen1> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = LatLng(13.736717, 100.523186);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps - Basic")),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 10.0,
        ),
      ),
    );
  }
}
