import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'show_tasks.dart';
import 'dart:convert';void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ShowTask(),
    );
  }
}
