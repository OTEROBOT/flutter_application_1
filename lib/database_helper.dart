import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('contact.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Create table group
    await db.execute('''
    CREATE TABLE Groups(
      groupId INTEGER PRIMARY KEY AUTOINCREMENT,
      groupName TEXT NOT NULL
    )
    ''');

    // Create table contact
    await db.execute('''
    CREATE TABLE Contacts(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      firstName TEXT NOT NULL,
      lastName TEXT,
      email TEXT,
      phone TEXT,
      groupId INTEGER,
      FOREIGN KEY(groupId) REFERENCES Groups(groupId)
    )
    ''');
  }

  // ฟังก์ชันในการเพิ่มข้อมูลในตาราง Groups
  Future<int> insertGroup(String groupName) async {
    final db = await instance.database;
    final data = {'groupName': groupName};

    return await db.insert('Groups', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // ฟังก์ชันในการอ่านข้อมูลจาก Groups
  Future<List<Map<String, dynamic>>> fetchGroups() async {
    final db = await instance.database;
    return await db.query('Groups');
  }

  // ฟังก์ชันในการอัปเดตข้อมูลในตาราง Groups
  Future<int> updateGroup(Map<String, dynamic> group, int groupId) async {
    final db = await instance.database;
    return await db.update(
      'Groups',
      group,
      where: 'groupId = ?',
      whereArgs: [groupId],
    );
  }

  // ฟังก์ชันในการลบจากตาราง Groups
  Future<int> deleteGroup(int groupId) async {
    final db = await instance.database;
    return await db.delete(
      'Groups',
      where: 'groupId = ?',
      whereArgs: [groupId],
    );
  }
}
