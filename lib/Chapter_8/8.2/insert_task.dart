import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart';

class InsertTask extends StatefulWidget {
  const InsertTask({super.key});

  @override
  State<InsertTask> createState() => _InsertTaskState();
}

class _InsertTaskState extends State<InsertTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> insertTask(BuildContext context) async {
    var url = Uri.parse("${PrefixURL.urlPrefix}/insert_task.php");
    await http.post(url, body: {
      'title': titleController.text,
      'description': descriptionController.text,
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insert New Task')),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 10,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => insertTask(context),
            child: const Text('Create New'),
          ),
        ],
      ),
    );
  }
}