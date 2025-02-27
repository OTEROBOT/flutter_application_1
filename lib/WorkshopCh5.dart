import 'package:flutter/material.dart';
import 'WorkshopCh5_2.dart'; // เรียกใช้ไฟล์ Workshop5_2

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop บทที่ 5',
      theme: ThemeData(primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      home: const Workshop5_2(),
    );
  }
}
