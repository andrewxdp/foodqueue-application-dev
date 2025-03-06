import 'package:flutter/material.dart';
import 'dart:async';

class CancleDialogWidget extends StatefulWidget {
  const CancleDialogWidget({super.key});

  @override
  State<CancleDialogWidget> createState() => _CancleDialogWidgetState();
}

class _CancleDialogWidgetState extends State<CancleDialogWidget> {
  int _start = 20;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        timer.cancel();
        Navigator.pop(context, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "คุณได้ทำการยกเลิกการจองโต๊ะ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            "โปรดรอ.....",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF676767)),
          ),
          SizedBox(height: 30),
          Text(
            "$_start", // แสดงค่า _start
            style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFB534)),
          ),
          SizedBox(height: 30),
          Text(
            "วินาที",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF676767)),
          ),
        ],
      ),
    ));
  }
}
