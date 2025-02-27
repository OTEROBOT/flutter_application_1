import 'package:flutter/material.dart';

class Showinfo extends StatefulWidget {
  const Showinfo({super.key});

  @override
  State<Showinfo> createState() => _ShowinfoState();
}

class _ShowinfoState extends State<Showinfo> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  String data = ''; // กำหนดค่าเริ่มต้น

  // ฟังก์ชันแสดงข้อมูล
  void showdata() {
    setState(() { // ใช้ setState เพื่ออัปเดต UI
      data = 'Email : ${_email.value.text}\n';
      data += 'Name : ${_name.value.text}\n';
      data += 'Phone : ${_phone.value.text}\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Information'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20), // เพิ่ม margin รอบ Container
        padding: const EdgeInsets.all(16.0), // เพิ่ม padding ภายใน Container
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Input personal data...',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 166, 0, 255),
                fontFamily: 'Itim',
              ),
            ),
            const SizedBox(height: 16), // Space between elements
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter email...',
                border: OutlineInputBorder(),
              ),
              controller: _email,
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Enter name...',
                border: OutlineInputBorder(),
              ),
              controller: _name,
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Enter phone number...',
                border: OutlineInputBorder(),
              ),
              controller: _phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: showdata, // เรียกฟังก์ชันแสดงข้อมูล
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 0, 166),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'แสดงข้อมูล',
                style: TextStyle(
                  fontFamily: 'Itim',
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              data,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
