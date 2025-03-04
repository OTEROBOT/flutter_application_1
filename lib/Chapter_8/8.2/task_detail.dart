import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart';
import 'model/task.dart';
import 'update_task.dart';

class TaskDetail extends StatefulWidget {
  final Task task;

  const TaskDetail({super.key, required this.task});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  Future<void> deleteTask(BuildContext context) async {
    var url = Uri.parse("${PrefixURL.urlPrefix}/delete_task.php");
    await http.post(url, body: {
      'id': widget.task.id.toString(),
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  void confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                deleteTask(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title: ${widget.task.title}",
              style: const TextStyle(fontSize: 20),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Text(
              "Description: ${widget.task.description}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateTask(task: widget.task),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}