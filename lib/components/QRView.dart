import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class QRview extends StatefulWidget {
  final String selectedTable;
  const QRview({super.key, required this.selectedTable});

  @override
  State<QRview> createState() => _QRviewState();
}

class _QRviewState extends State<QRview> {
  int _start = 90;
  late Timer _timer;
  Future<void> selectedTable(String selectedTable) async {
    try {
      final authToken = localStorage.getItem("token");
      var response = await http.post(
          Uri.parse("http://localhost:3000/table/selected"),
          headers: {
            "authorization": "Bearer $authToken",
            "Content-Type": "application/json"
          },
          body: jsonEncode({"selectedTable": selectedTable}));
      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, "/");

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('เลือกโต๊ะสำเร็จ!'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (error) {
      print("Error Selected Table");
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_start > 0) {
            _start--;
          } else {
            _timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white, automaticallyImplyLeading: false),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "แสกน QR Code ที่โต๊ะที่คุณจอง",
              style: TextStyle(fontSize: 20, color: Color(0xFF32343E)),
            ),
            const SizedBox(height: 10),
            Text(
              widget.selectedTable,
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: const Color.fromARGB(255, 190, 189, 189),
              height: 300,
              padding: const EdgeInsets.all(50),
              child: Image.asset('assets/qrMock.jpg'),
            ),
            const SizedBox(height: 20),
            const Text(
              "โปรดแสกนภายใน",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "$_start วินาที",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFFFB534),
                minimumSize: const Size(200, 62),
              ),
              onPressed: () {
                selectedTable(widget.selectedTable);
              },
              child: const Center(
                child: Text(
                  "แสกน QR Code",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFCED7DF),
                minimumSize: const Size(200, 62),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Center(
                child: Text(
                  "ยกเลิก",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
