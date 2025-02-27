import 'package:flutter/material.dart';

class Workshop5_2 extends StatelessWidget {
  const Workshop5_2({super.key});

  @override
  Widget build(BuildContext context) {
    // ตรวจสอบการหมุนหน้าจอ (portrait หรือ landscape)
    var orientation = MediaQuery.of(context).orientation;
    
    // กำหนดขนาดของกล่อง
    double itemWidth = orientation == Orientation.portrait ? 300 : 200;
    double itemHeight = orientation == Orientation.portrait ? 150 : 200;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workshop 5.2'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          // ถ้าเป็น portrait ใช้ Column, ถ้าเป็น landscape ใช้ Row
          child: orientation == Orientation.portrait
              ? Column( // โหมดแนวตั้ง (portrait)
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    boxContainer('One', itemWidth, itemHeight),
                    boxContainer('Two', itemWidth, itemHeight),
                    boxContainer('Three', itemWidth, itemHeight),
                  ],
                )
              : Row( // โหมดแนวนอน (landscape)
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    boxContainer('One', itemWidth, itemHeight),
                    boxContainer('Two', itemWidth, itemHeight),
                    boxContainer('Three', itemWidth, itemHeight),
                  ],
                ),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างกล่อง
  Widget boxContainer(String text, double width, double height) => Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
