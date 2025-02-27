import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'map1.dart';
import 'map2.dart';
import 'map3.dart';
import 'map4.dart';
import 'map333.dart';
import 'map444.dart';
import 'show_tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermission(); // ขอสิทธิ์ก่อนเริ่มแอป
  runApp(MyApp());
}

Future<void> requestPermission() async {
  PermissionStatus status = await Permission.location.request();
  if (status.isDenied) {
    print("❌ ผู้ใช้ปฏิเสธการเข้าถึงตำแหน่ง");
  } else if (status.isGranted) {
    print("✅ อนุญาตให้เข้าถึงตำแหน่งแล้ว");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen4444(),
    );
  }
}
