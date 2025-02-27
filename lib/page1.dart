import 'package:flutter/material.dart';
import 'page2.dart'; // เรียกใช้ไฟล์ PageTwo

class PageOne extends StatelessWidget {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page ONE')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: firstnameController,
              decoration: InputDecoration(labelText: 'ชื่อ :'),
            ),
            TextField(
              controller: lastnameController,
              decoration: InputDecoration(labelText: 'นามสกุล :'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'อีเมล :'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'เบอร์โทร :'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // สร้างข้อมูลที่ต้องการส่ง
                Map<String, String> data = {
                  'firstname': firstnameController.text,
                  'lastname': lastnameController.text,
                  'email': emailController.text,
                  'Phone': phoneController.text,
                };

                // ส่งข้อมูลไปหน้า page2
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageTwo(data: data)),
                );
              },
              child: Text(
                'ส่งข้อมูล',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
