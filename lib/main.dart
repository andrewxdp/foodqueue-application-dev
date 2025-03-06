import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/Account_Page.dart';
import 'package:foodqueuedev/components/Homepage.dart';
import 'package:foodqueuedev/components/Layout.dart';
import 'package:foodqueuedev/components/Login_Page.dart';
import 'package:foodqueuedev/components/Order_Page.dart';
import 'package:foodqueuedev/components/QRView.dart';
import 'package:foodqueuedev/components/Restaurant_Page.dart';
import 'package:foodqueuedev/components/SelectTablePage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "foodqueue",
      theme: ThemeData(
        textTheme: GoogleFonts.mitrTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/select_table': (context) => SelectTablePage(),
        '/restaurant': (context) => Restaurant_Page(),
        '/order': (context) => Order_Page(),
        '/account': (context) => Account_Page(),
      },
      home: Login_Page(),
    );
  }
}
