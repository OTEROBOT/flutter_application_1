import 'package:flutter/material.dart';

void main() {
  runApp(const Mytdee());
}

class Mytdee extends StatelessWidget {
  const Mytdee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TDEECalculator(),
    );
  }
}

class TDEECalculator extends StatefulWidget {
  const TDEECalculator({super.key});

  @override
  State<TDEECalculator> createState() => _TDEECalculatorState();
}

class _TDEECalculatorState extends State<TDEECalculator> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String gender = "male"; // ค่าเริ่มต้น
  double activityLevel = 1.2; // ค่าเริ่มต้น
  String bmrResult = "";
  String tdeeResult = "";

  void calculateTDEE() {
    setState(() {
      final int age = int.tryParse(_ageController.text) ?? 0;
      final double weight = double.tryParse(_weightController.text) ?? 0;
      final double height = double.tryParse(_heightController.text) ?? 0;

      if (age > 0 && weight > 0 && height > 0) {
        double bmr;
        if (gender == "male") {
          bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
        } else {
          bmr = 665 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
        }

        final double tdee = bmr * activityLevel;

        bmrResult = "BMR: ${bmr.toStringAsFixed(2)} cal";
        tdeeResult = "TDEE: ${tdee.toStringAsFixed(2)} cal";
      } else {
        bmrResult = "Please fill all fields correctly.";
        tdeeResult = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TDEE Calculator BY OTE 66040233110'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/OTEROBOT/IMGOTE/unnamed.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),

            // Gender Selection
            Row(
              children: [
                const Text("เพศ:", style: TextStyle(fontSize: 18)),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Radio<String>(
                      value: "male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    const Text("ชาย"),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: "female",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    const Text("หญิง"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Input Fields
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "ป้อนอายุ",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "ป้อนน้ำหนัก (กก.)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "ป้อนส่วนสูง (ซม.)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Activity Level Dropdown
            DropdownButtonFormField<double>(
              value: activityLevel,
              items: [
                DropdownMenuItem(
                  value: 1.2,
                  child: Text("No Exercise"),
                ),
                DropdownMenuItem(
                  value: 1.375,
                  child: Text("Light Exercise (1-3 days/week)"),
                ),
                DropdownMenuItem(
                  value: 1.55,
                  child: Text("Moderate Exercise (4-5 days/week)"),
                ),
                DropdownMenuItem(
                  value: 1.7,
                  child: Text("Heavy Exercise (6-7 days/week)"),
                ),
                DropdownMenuItem(
                  value: 1.9,
                  child: Text("Athlete (2 times/day)"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  activityLevel = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: "กิจกรรมที่ทำประจำวัน",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Calculate Button
            ElevatedButton(
              onPressed: calculateTDEE,
              child: const Text(
                "คำนวณ",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),

            // Results
            Text(
              bmrResult,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              tdeeResult,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
