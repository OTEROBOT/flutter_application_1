import 'package:flutter/material.dart';
import 'update_task.dart';
import 'task.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart';
import 'dart:convert';

class TaskDetail extends StatefulWidget {
  final Task task;
  const TaskDetail({required this.task});

  @override
  State<TaskDetail> createState() => _DetailState();
}

class _DetailState extends State<TaskDetail> {

  // Function to delete Task
  void deleteTask(BuildContext context) async {
    var url = Uri.parse("${PrefixURL.url_prefix}/delete_task.php");
    await http.post(url, body: {
      'id': widget.task.id.toString(),
    });

    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  // Confirm delete dialog
  void confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Do you want to delete this task?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () => deleteTask(context),
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
        actions: <Widget>[
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Title: ${widget.task.title}", style: const TextStyle(fontSize: 20)),
            const Padding(padding: EdgeInsets.all(10)),
            Text("Description: ${widget.task.description}", style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.all(10)),
            Text("First Name: ${widget.task.firstname}", style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.all(10)),
            Text("Last Name: ${widget.task.lastname}", style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.all(10)),
            Text("Email: ${widget.task.email}", style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.all(10)),
            Text("Phone: ${widget.task.phone}", style: const TextStyle(fontSize: 16)),
            const Padding(padding: EdgeInsets.all(10)),
            Text("Group: ${widget.task.group}", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateTask(task: widget.task),
            ),
          );
        },
      ),
    );
  }
}
