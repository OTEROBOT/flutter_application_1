import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final Map<String, String> data;

  PageTwo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page two')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ชื่อ : ${data['firstname']}',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            Text(
              'นามสกุล : ${data['lastname']}',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            Text(
              'Email : ${data['email']}',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            Text(
              'เบอร์มือถือ : ${data['Phone']}',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
