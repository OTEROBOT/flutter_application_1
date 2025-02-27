import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class MapScreen4444 extends StatefulWidget {
  @override
  _MapScreen3State createState() => _MapScreen3State();
}

class _MapScreen3State extends State<MapScreen4444> {
  late GoogleMapController mapController;
  List<Marker> _markers = [];
  LatLng _currentPosition = LatLng(13.736717, 100.523186);
  String? _placeName;

  @override
  void initState() {
    super.initState();
    HttpOverrides.global = MyHttpOverrides();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getCurrentLocation();
    _fetchMarkers();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
      mapController.animateCamera(
        CameraUpdate.newLatLng(_currentPosition), // เลื่อนไปที่ตำแหน่งของ Marker
      );
      _addCurrentLocationMarker();
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  void _addCurrentLocationMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("current_location"),
          position: _currentPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: "Your Location"),
        ),
      );
    });
  }

  Future<void> _fetchMarkers() async {
    try {
      final response = await http.get(Uri.parse('https://hosting.udru.ac.th/its66040233110/AppMap/get_location.php'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Marker> markersList = data.map((location) {
          try {
            double lat = double.parse(location['latitude']);
            double lng = double.parse(location['longitude']);
            return Marker(
              markerId: MarkerId(location['id'].toString()),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: location['name']),
            );
          } catch (e) {
            print("Error parsing marker: ${location['name']} - $e");
            return null;
          }
        }).where((marker) => marker != null).toList().cast<Marker>();

        setState(() {
          _markers.clear();
          _markers.addAll(markersList);
          _addCurrentLocationMarker();
        });
      } else {
        print('Failed to load markers, Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching markers: $e');
    }
  }

  Future<void> _savePlaceName() async {
    if (_placeName != null && _placeName!.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse("https://hosting.udru.ac.th/its66040233110/AppMap/save_location.php"),
          body: {
            'name': _placeName!,
            'latitude': _currentPosition.latitude.toString(),
            'longitude': _currentPosition.longitude.toString(),
          },
        );

        if (response.statusCode == 200) {
          print("Place Name: $_placeName saved!");
          _fetchMarkers(); // Load markers again after saving
        } else {
          print("Failed to save place: ${response.statusCode}");
        }
      } catch (e) {
        print("Error saving place: $e");
      }
    } else {
      print("Please enter a place name.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps - Current Location & DB Markers")),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 10.0,
              ),
              myLocationEnabled: true,
              markers: Set.from(_markers),
              onTap: (LatLng position) {
                setState(() {
                  _currentPosition = position;
                  _placeName = null; // รีเซ็ตชื่อสถานที่เมื่อกดที่ตำแหน่งใหม่
                });
                mapController.animateCamera(
                  CameraUpdate.newLatLng(_currentPosition), // เลื่อนไปที่ตำแหน่งใหม่
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _placeName = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Enter Place Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _savePlaceName,
                  child: Text("Save Place Name"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
