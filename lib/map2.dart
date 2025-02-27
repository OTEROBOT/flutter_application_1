import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen2 extends StatefulWidget {
  const MapScreen2({super.key});

  @override
  State<MapScreen2> createState() => _MapScreen2State();
}

class _MapScreen2State extends State<MapScreen2> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng _currentPosition = const LatLng(17.42203, 102.80243); // ตำแหน่งเริ่มต้น
  final Set<Marker> _markers = {}; // ชุดของหมุด
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // ฟังก์ชันดึงตำแหน่งปัจจุบันและเพิ่มหมุด
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ตรวจสอบ Location Service
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

    // ตรวจสอบและขอสิทธิ์
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
          const SnackBar(
              content: Text('สิทธิ์ถูกปฏิเสธถาวร กรุณาเปิดใน Settings')),
        );
      }
      setState(() => _isLoading = false);
      return;
    }

    // ดึงตำแหน่งปัจจุบัน
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      // เพิ่มหมุดที่ตำแหน่งปัจจุบัน
      _markers.clear(); // ล้างหมุดเก่า (ถ้ามี)
      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentPosition,
          infoWindow: const InfoWindow(title: 'ตำแหน่งของฉัน'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
      _isLoading = false;
    });

    // อัปเดตตำแหน่งบนแผนที่
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition,
          zoom: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Maps - Current Location")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 10.0,
              ),
              markers: _markers, // เพิ่มหมุดลงในแผนที่
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}