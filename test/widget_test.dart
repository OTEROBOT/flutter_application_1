import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// นำเข้าไฟล์ที่ใช้ในโปรเจกต์ของคุณ
import 'package:flutter_application_1/show_tasks.dart';

void main() {
  testWidgets('Task list widget test', (WidgetTester tester) async {
    // Build the ShowTask widget and trigger a frame.
    await tester.pumpWidget(const ShowTask());

    // ตรวจสอบว่าแสดงข้อความในรายการหรือไม่
    expect(find.text('Task Management'), findsOneWidget); // ทดสอบว่าแสดง AppBar ที่มีชื่อ 'Task Management'
    
    // เพิ่มทดสอบอื่น ๆ ที่คุณต้องการ เช่น การตรวจสอบการแสดง Task หรือปุ่ม 'Add'
    expect(find.byIcon(Icons.add), findsOneWidget); // ทดสอบว่าไอคอน 'add' อยู่ใน UI หรือไม่
  });
}
