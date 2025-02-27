import 'package:flutter/material.dart';
import 'page1.dart'; // เรียกใช้ไฟล์ PageOne

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pageOne บทที่ 6 การเปลี่ยนหน้า workshop',
      theme: ThemeData(primarySwatch: Colors.deepPurple), // ใช้ Colors.deepPurple แทน
      debugShowCheckedModeBanner: false,
      home: PageOne(),
    );
  }
}
