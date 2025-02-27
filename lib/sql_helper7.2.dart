import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';


class SqlHelper {
  // สร้างตาราง
  static Future<void> createTable(Database database) async {
    await database.execute(
      "CREATE TABLE tasks("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "title TEXT, "
      "description TEXT)"
    );
  }

  // สร้างและเปิดฐานข้อมูล
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'dbtasks.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await createTable(db);
      },
    );
  }

  // เพิ่ม Task
  static Future<int> insertTask(String title, String description) async {
    final db = await SqlHelper.db();
    final data = {'title': title, 'description': description};
    final id = await db.insert(
      'tasks',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  // อ่าน Task ทั้งหมด
  static Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await SqlHelper.db();
    return db.query('tasks', orderBy: "id DESC");
  }

  // อ่าน Task เฉพาะที่ตรงกับ id
  static Future<List<Map<String, dynamic>>> getTaskById(int id) async {
    final db = await SqlHelper.db();
    return db.query(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
  }

  // อัปเดต Task
  static Future<int> updateTask(int id, String title, String description) async {
    final db = await SqlHelper.db();
    final data = {
      'title': title,
      'description': description,
    };
    final result = await db.update(
      'tasks',
      data,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  // ลบ Task เฉพาะที่ตรงกับ id
  static Future<void> deleteTask(int id) async {
    final db = await SqlHelper.db();
    try {
      await db.delete("tasks", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("เกิดข้อผิดพลาดบางประการในขณะลบข้อมูล: $err");
    }
  }
}
