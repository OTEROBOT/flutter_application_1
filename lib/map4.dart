import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop #9.4',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Map4(),
    );
  }
}

class Map4 extends StatefulWidget {
  const Map4({super.key});

  @override
  State<Map4> createState() => _Map4State();
}

class _Map4State extends State<Map4> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng _currentPosition = const LatLng(17.42203, 102.80243);
  final TextEditingController _nameController = TextEditingController();
  final Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchLocations();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('กรุณาเปิด Location Services')),
        );
      }
      setState(() => _isLoading = false);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('กรุณาอนุญาตให้เข้าถึงตำแหน่ง')),
          );
        }
        setState(() => _isLoading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('สิทธิ์ถูกปฏิเสธถาวร กรุณาเปิดใน Settings')),
        );
      }
      setState(() => _isLoading = false);
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentPosition,
          infoWindow: const InfoWindow(title: 'ตำแหน่งปัจจุบัน'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          draggable: true,
          onDragEnd: (newPosition) {
            setState(() {
              _currentPosition = newPosition;
            });
          },
        ),
      );
      _isLoading = false;
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition, zoom: 14),
      ),
    );
  }

  Future<void> _fetchLocations() async {
    const url = 'http://hosting.udru.ac.th/its66040233110/AppMap/get_location.php'; // เปลี่ยนเป็น HTTP
    try {
      final response = await http.get(Uri.parse(url));
      print('Fetch Response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> locations = jsonDecode(response.body);
        setState(() {
          _markers.addAll(locations.map((location) => Marker(
                markerId: MarkerId(location['id'].toString()),
                position: LatLng(
                  double.parse(location['latitude']),
                  double.parse(location['longitude']),
                ),
                infoWindow: InfoWindow(title: location['name']),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              )));
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('ไม่สามารถดึงข้อมูลได้: HTTP ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาดในการดึงข้อมูล: $e')),
        );
      }
    }
  }

  Future<void> _saveLocation() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณาใส่ชื่อสถานที่')),
      );
      return;
    }

    final url = Uri.parse("http://hosting.udru.ac.th/its66040233110/AppMap/save_location.php"); // เปลี่ยนเป็น HTTP

    final Map<String, String> body = {
      'name': _nameController.text,
      'latitude': _currentPosition.latitude.toString(),
      'longitude': _currentPosition.longitude.toString(),
    };

    print('Sending to save_location.php: $body');

    try {
      final response = await http.post(url, body: body);
      print('Save Response: ${response.statusCode} - ${response.body}');

      final result = jsonDecode(response.body);
      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('บันทึกตำแหน่งสำเร็จ')),
        );
        _nameController.clear();
        _fetchLocations();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาดจากเซิร์ฟเวอร์: ${result['error']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้: $e')),
      );
      print('Error connecting to server: $e');
    }
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'current_location');
      _currentPosition = position;
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentPosition,
          infoWindow: const InfoWindow(title: 'ตำแหน่งใหม่'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          draggable: true,
          onDragEnd: (newPosition) {
            setState(() {
              _currentPosition = newPosition;
            });
          },
        ),
      );
    });
    print('New position set: $_currentPosition');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Workshop #9.4 - Save Location")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 10.0,
                  ),
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onTap: _onMapTapped,
                ),
                Positioned(
                  bottom: 100,
                  left: 20,
                  right: 20,
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "ใส่ชื่อสถานที่...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: _saveLocation,
                    child: const Text("บันทึกตำแหน่ง"),
                  ),
                ),
              ],
            ),
    );
  }
}