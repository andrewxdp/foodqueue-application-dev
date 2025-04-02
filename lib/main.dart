import 'package:flutter/material.dart';
import 'package:foodqueuedev/account/Account_Page.dart';
import 'package:foodqueuedev/account/aboutAccout.dart';
import 'package:foodqueuedev/components/Homepage.dart';
import 'package:foodqueuedev/components/Layout.dart';
import 'package:foodqueuedev/components/Login_Page.dart';
import 'package:foodqueuedev/components/Order_Page.dart';
import 'package:foodqueuedev/components/ProductDetails_Page.dart';
import 'package:foodqueuedev/components/QRView.dart';
import 'package:foodqueuedev/components/Register_Page.dart';
import 'package:foodqueuedev/components/RestaurantDetailPage.dart';
import 'package:foodqueuedev/components/Restaurant_Page.dart';
import 'package:foodqueuedev/components/SelectTablePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? isLogin = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLogin = localStorage.getItem('isLogin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "foodqueue",
      theme: ThemeData(
        textTheme: GoogleFonts.mitrTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: isLogin == 'true' ? '/' : '/login',
      routes: {
        '/': (context) => Layout(),
        // '/select_table': (context) => SelectTablePage(),
        '/restaurant': (context) => Restaurant_Page(),
        '/order': (context) => Order_Page(),
        '/login': (context) => Login_Page(),
      },
    );
  }
}
