import 'package:flutter/material.dart';
import 'sql_helper.dart';

//ของ7.2
class ShowTask extends StatefulWidget {
  const ShowTask({super.key});

  @override
  State<ShowTask> createState() => _ShowTaskState();
}

class _ShowTaskState extends State<ShowTask> {
  List<Map<String, dynamic>> _tasks = [];
  bool _isLoading = true;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshTasks();
  }

  Future<void> refreshTasks() async {
    final data = await SqlHelper.getAllTasks();
    setState(() {
      _tasks = data;
      _isLoading = false;
    });
  }

  void showForm(int? id) async {
    if (id != null) {
      final existingTask =
          _tasks.firstWhere((element) => element['id'] == id);
      titleController.text = existingTask['title'];
      descriptionController.text = existingTask['description'];
    } else {
      titleController.clear();
      descriptionController.clear();
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (id == null) {
                  await addTask();
                } else {
                  await updateTask(id);
                }
                titleController.clear();
                descriptionController.clear();
                Navigator.of(context).pop();
              },
              child: Text(id == null ? 'Create New' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addTask() async {
    await SqlHelper.insertTask(titleController.text, descriptionController.text);
    refreshTasks();
  }

  Future<void> updateTask(int id) async {
    await SqlHelper.updateTask(id, titleController.text, descriptionController.text);
    refreshTasks();
  }

  void deleteTask(int id) async {
    await SqlHelper.deleteTask(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Successfully deleted a task!')),
    );
    refreshTasks();
  }

  void confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Do you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              deleteTask(id);
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(null),
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) => Card(
                color: Colors.amber,
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_tasks[index]['title']),
                  subtitle: Text(_tasks[index]['description']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => showForm(_tasks[index]['id']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              confirmDelete(context, _tasks[index]['id']),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
