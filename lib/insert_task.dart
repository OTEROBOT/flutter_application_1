import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart'; // Ensure this imports the file where PrefixURL is defined

class InsertTask extends StatefulWidget {
  const InsertTask({super.key});

  @override
  State<InsertTask> createState() => _InsertTaskState();
}

class _InsertTaskState extends State<InsertTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController groupController = TextEditingController();

  // Function to add a new task
  void insertTask(BuildContext context) async {
    var url = Uri.parse("${PrefixURL.url_prefix}/insert_task.php");

    // Send data to PHP API using POST
    var response = await http.post(url, body: {
      'title': titleController.text,
      'description': descriptionController.text,
      'firstname': firstnameController.text,
      'lastname': lastnameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'group': groupController.text,
    });

    if (response.statusCode == 200) {
      // If successful, go back to the main screen
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    } else {
      // If there's an error, show a Snackbar
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
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: firstnameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lastnameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: groupController,
              decoration: const InputDecoration(labelText: 'Group'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Create new"),
              onPressed: () => insertTask(context),
            ),
          ],
        ),
      ),
    );
  }
}
