import 'package:flutter/material.dart';
import 'group_menage.dart'; // แก้ไขชื่อไฟล์ให้ตรงกับคลาส GroupManage

Widget drawerMenu(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // Drawer header
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 89, 25, 240),
          ),
          child: const Text(
            'Menu',
            style: TextStyle(
              color: Colors.white, // เปลี่ยนสีตัวอักษรให้อ่านง่าย
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GroupMenage()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.group),
          title: const Text('Group Data'),
          onTap: () {
            // งานที่ทำเมื่อคลิกที่เมนูนี้
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Contact Data'),
          onTap: () {
            // งานที่ทำเมื่อคลิกที่เมนูนี้
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help'),
          onTap: () {
            // งานที่ทำเมื่อคลิกที่เมนูนี้
          },
        ),
      ],
    ),
  );
}
