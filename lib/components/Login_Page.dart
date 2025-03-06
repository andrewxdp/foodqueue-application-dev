import 'package:flutter/material.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text(
              'เข้าสู่ระบบ',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'กรุณาเข้าสู่ระบบด้วยบัญชีที่คุณมีอยู่',
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
