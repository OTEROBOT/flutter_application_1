import 'package:flutter/material.dart';
import 'Chapter_8/8.1/photo.dart';
import 'Chapter_8/8.2/task_list.dart';

//สำหรับรันบท 8 ทั้ง 8.1 และ 8.2

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workshop Chapter 8',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/workshop_8_1': (context) => const PhotoListScreen(),
        '/workshop_8_2': (context) => const TaskListScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter 8 Workshops'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/workshop_8_1');
              },
              child: const Text('Go to Workshop #8.1'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/workshop_8_2');
              },
              child: const Text('Go to Workshop #8.2'),
            ),
          ],
        ),
      ),
    );
  }
}