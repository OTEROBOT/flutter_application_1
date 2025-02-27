import 'package:flutter/material.dart';
import 'task.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart';
import 'dart:convert';

class UpdateTask extends StatefulWidget {
  final Task task;
  const UpdateTask({required this.task}); // การประกาศ constructor ให้ถูกต้อง

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // ฟังก์ชัน update ข้อมูล
  void updateTask(BuildContext context) async {
    var url = Uri.parse("${PrefixURL.url_prefix}/update_task.php");
    await http.post(url, body: {
      'id': widget.task.id.toString(),  // แก้ไขการใช้ toString() ให้ถูกต้อง
      'title': titleController.text,
      'description': descriptionController.text,
    });

    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    // กำหนดค่าเริ่มต้นให้กับตัวแปร controller
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Task'),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ), // TextField
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 10,
          ), // TextField
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text("Update"),
            onPressed: () => updateTask(context),  // เรียกใช้ฟังก์ชัน update
          ), // ElevatedButton
        ],
      ), // Column
    ); // Scaffold
  }
}
