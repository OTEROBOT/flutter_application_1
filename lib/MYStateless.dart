import 'package:flutter/material.dart';

// StatelessWidget Example
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stateless Widget Example',
          style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 132, 49, 255)),
        ),
      ), // AppBar
      body: Center(
        child: Text(
          'Hello, I am a Stateless widget!!',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ), // Text
      ), // Center
    ); // Scaffold
  }
}
