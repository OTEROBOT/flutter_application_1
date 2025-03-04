import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart';
import 'model/task.dart';

class UpdateTask extends StatefulWidget {
  final Task task;

  const UpdateTask({super.key, required this.task});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
  }

  Future<void> updateTask(BuildContext context) async {
    var url = Uri.parse("${PrefixURL.urlPrefix}/update_task.php");
    await http.post(url, body: {
      'id': widget.task.id.toString(),
      'title': titleController.text,
      'description': descriptionController.text,
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Task')),
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
            onPressed: () => updateTask(context),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}