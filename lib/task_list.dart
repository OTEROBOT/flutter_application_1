import 'insert_task.dart';
import 'task.dart';
import 'task_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart'; // Ensure this imports the file where PrefixURL is defined
import 'dart:convert';
import 'dart:async';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    tasks = getTaskList();
  }

  Future<List<Task>> getTaskList() async {
    var url = Uri.parse("${PrefixURL.url_prefix}/ALL_tasks.php"); // Corrected URL to use url_prefix
    final response = await http.get(url);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Task> tasks = items.map<Task>((json) {
      return Task.fromJson(json); // Now works because 'fromJson' is defined
    }).toList();
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task management"),
      ),
      body: Center(
        child: FutureBuilder<List<Task>>(
          future: tasks,
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.task),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      data.title,
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TaskDetail(task: data)),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InsertTask()),
          );
        },
      ),
    );
  }
}
