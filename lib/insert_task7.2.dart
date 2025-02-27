import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart'; //  prefix_url.dart อยู่ในโฟลเดอร์เดียวกัน
import 'dart:convert';

class InsertTask extends StatefulWidget {
  const InsertTask({super.key});

  @override
  State<InsertTask> createState() => _InsertTaskState();
}

class _InsertTaskState extends State<InsertTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // ฟังก์ชันเพื่อเพิ่ม Task ใหม่
  void insertTask(BuildContext context) async {
    var url = Uri.parse("${PrefixURL.url_prefix}/insert_task.php");

    // ส่งข้อมูลไปยัง PHP API ด้วย POST
    var response = await http.post(url, body: {
      'title': titleController.text,
      'description': descriptionController.text,
    });

    if (response.statusCode == 200) {
      // ถ้าส่งข้อมูลสำเร็จ ให้กลับไปที่หน้าหลัก
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    } else {
      // หากเกิดข้อผิดพลาดในการเพิ่มข้อมูล
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to insert task!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert new Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ), // TextField for Title
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
            ), // TextField for Description
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Create new"),
              onPressed: () => insertTask(context),
            ), // ElevatedButton for inserting new task
          ],
        ),
      ),
    );
  }
}
