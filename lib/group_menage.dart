import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'group_model.dart';

class GroupMenage extends StatefulWidget {
  @override
  _GroupMenageState createState() => _GroupMenageState();
}

class _GroupMenageState extends State<GroupMenage> {
  List<Group> _group = [];
  int? groupId; // ใช้สำหรับติดตาม ID ของกลุ่มที่กำลังแก้ไข
  bool isLoading = false; // ใช้แสดงสถานะการโหลดข้อมูล
  final TextEditingController _groupNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGroup(); // โหลดข้อมูลกลุ่มตอนเริ่มต้น
  }

  Future<void> _loadGroup() async {
    setState(() {
      isLoading = true; // เริ่มโหลดข้อมูล
    });

    try {
      final List<Map<String, dynamic>> groupData =
          await DatabaseHelper.instance.fetchGroups();
      setState(() {
        _group = groupData.map((data) => Group.fromMap(data)).toList();
      });
    } catch (e) {
      print('Error loading groups: $e'); // จัดการข้อผิดพลาด
    } finally {
      setState(() {
        isLoading = false; // หยุดโหลดข้อมูล
      });
    }
  }

  Future<void> _addGroup() async {
    if (_groupNameController.text.isNotEmpty) {
      try {
        Group newGroup = Group(groupName: _groupNameController.text);
        await DatabaseHelper.instance.insertGroup(newGroup.groupName);
        _loadGroup();
        _clearForm();
      } catch (e) {
        print('Error adding group: $e');
      }
    }
  }

  Future<void> _updateGroup(int id) async {
    if (_groupNameController.text.isNotEmpty) {
      try {
        Group updatedGroup = Group(groupId: id, groupName: _groupNameController.text);
        await DatabaseHelper.instance.updateGroup(updatedGroup.toMap(), id);
        _loadGroup();
        _clearForm();
      } catch (e) {
        print('Error updating group: $e');
      }
    }
  }

  Future<void> _deleteGroup(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this group?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await DatabaseHelper.instance.deleteGroup(id);
        _loadGroup();
      } catch (e) {
        print('Error deleting group: $e');
      }
    }
  }

  void _clearForm() {
    _groupNameController.clear();
    setState(() {
      groupId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Menage'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      labelText: 'Group Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (groupId == null) {
                          _addGroup();
                        } else {
                          _updateGroup(groupId!);
                        }
                      },
                      child: Text(groupId == null ? 'Add Group' : 'Update Group'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _clearForm,
                      child: Text('Clear'),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Group Name')),
                        DataColumn(label: Text('Manage')),
                      ],
                      rows: _group.map((group) {
                        return DataRow(
                          cells: [
                            DataCell(Text(group.groupId?.toString() ?? '-')),
                            DataCell(Text(group.groupName)),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      _groupNameController.text = group.groupName;
                                      setState(() {
                                        groupId = group.groupId;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      if (group.groupId != null) {
                                        _deleteGroup(group.groupId!);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
