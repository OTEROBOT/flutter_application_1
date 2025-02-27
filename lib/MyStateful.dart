// MyStateful.dart
import 'package:flutter/material.dart';

// StatefulWidget Example
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String data = 'Hello, I am OTEROBOT';

  void updateMessage() {
    setState(() {
      data = 'State changed!! You clicked the button';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateful Widget Example'),
      ), // AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 18,
              ),
            ), // Text
            const SizedBox(height: 20), // Space between elements
            ElevatedButton(
              onPressed: updateMessage,
              child: const Text('Click ME'),
            ), // ElevatedButton
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }
}
