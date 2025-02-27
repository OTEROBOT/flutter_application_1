import 'package:flutter/material.dart';
import 'task.dart';

class UpdateTask extends StatefulWidget {
  final Task task;
  const UpdateTask({required this.task});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              child: const Text('Update'),
              onPressed: () {
                // Update the task logic here
                // After updating, go back to the previous screen
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
