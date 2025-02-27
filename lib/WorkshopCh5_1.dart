import 'package:flutter/material.dart';

class Workshop5_1 extends StatelessWidget {
  const Workshop5_1({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width.toStringAsFixed(2);
    var height = MediaQuery.of(context).size.height.toStringAsFixed(2);
    var orient = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workshop 5.1'), // แก้ไขชื่อใน AppBar
      ),
      body: Center(
        child: Text(
          'Width : $width\nHeight : $height\nOrientation : $orient',
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 210, 17, 227),
          ),
        ),
      ),
    );
  }
}
