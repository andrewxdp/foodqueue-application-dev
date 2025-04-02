import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodqueuedev/account/Account_Page.dart';
import 'package:foodqueuedev/components/Homepage.dart';
import 'package:foodqueuedev/components/Order_Page.dart';
import 'package:foodqueuedev/components/Restaurant_Page.dart';
import 'package:foodqueuedev/components/SelectTablePage.dart';
import 'package:foodqueuedev/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  String? selectedTable;
  final PageController _pageController = PageController();
  List<UserData> user = [];
  late Future<Uint8List> _image;
  int _minutes = 30;
  int _seconds = 0;
  late Timer _timer;
  Future<void> fetchUser() async {
    try {
      final authToken = localStorage.getItem("token");
      var response = await http.get(Uri.parse("http://localhost:3000/user"),
          headers: {"authorization": "Bearer $authToken"});
      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        if (userData is List && userData.isNotEmpty) {
          setState(() {
            user = userData
                .map((userJson) => UserData.fromJson(userJson))
                .toList();
            _image = fetchProfileImage();
          });
        } else {
          throw Exception("ไม่พบข้อมูลผู้ใช้ใน response");
        }
      } else {
        throw Exception("Fail to load user");
      }
    } catch (error) {
      print("Error fetching user: $error");
    }
  }

  Future<Uint8List> fetchProfileImage() async {
    final authToken = localStorage.getItem("token");
    final response = await http.get(
        Uri.parse('http://localhost:3000/user/profile'),
        headers: {"authorization": "Bearer $authToken"});
    if (response.statusCode == 200) {
      return response.bodyBytes; // รับข้อมูล byte array
    } else {
      throw Exception('Failed to load image');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_minutes == 0 && _seconds == 0) {
        _timer.cancel();
        deleteTable();
      } else {
        setState(() {
          if (_seconds == 0) {
            if (_minutes > 0) {
              _minutes--;
              _seconds = 59;
            }
          } else {
            _seconds--;
          }

          localStorage.setItem("minute", _minutes.toString());
          localStorage.setItem("second", _seconds.toString());
        });
      }
    });
  }

  Future<void> deleteTable() async {
    try {
      final authToken = localStorage.getItem("token");
      var response = await http.delete(
          Uri.parse("http://localhost:3000/table/selected/delete"),
          headers: {"authorization": "Bearer $authToken"});
      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, "/");
        localStorage.removeItem("minute");
        localStorage.removeItem("second");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('คืนโต๊ะสำเร็จ'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (error) {
      print("Error delete table");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
    _image = fetchProfileImage();

    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Ensure timer is canceled when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      // ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          Homepage(
            pageController: _pageController,
            username: user.isNotEmpty ? user[0].username : '',
            deleteTable: deleteTable,
          ),
          SelectTablePage(
            email: user.isNotEmpty ? user[0].email : '',
            deleteTable: deleteTable,
          ),
          Restaurant_Page(),
          Order_Page(),
          Account_Page(
            username: user.isNotEmpty ? user[0].username : '',
            email: user.isNotEmpty ? user[0].email : '',
            imageProfileUrl: _image,
            description: user.isNotEmpty
                ? user[0].profileData[0].description!
                : 'คำอธิบายตัวคุณ',
            fetchUser: fetchUser,
            fetchProfile: fetchProfileImage,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.white,
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return const TextStyle(
                    color: Color(0xFFFC6E2A),
                    fontSize: 12,
                  );
                }
                return const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                );
              },
            ),
          ),
          child: NavigationBar(
            backgroundColor: Colors.white,
            height: 65,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, size: 28),
                selectedIcon:
                    Icon(Icons.home_filled, color: Color(0xFFFC6E2A), size: 30),
                label: 'หน้าแรก',
              ),
              NavigationDestination(
                icon: Icon(Icons.table_restaurant_outlined, size: 28),
                selectedIcon: Icon(Icons.table_restaurant,
                    color: Color(0xFFFC6E2A), size: 30),
                label: 'จองโต๊ะ',
              ),
              NavigationDestination(
                icon: Icon(Icons.restaurant_outlined, size: 28),
                selectedIcon:
                    Icon(Icons.restaurant, color: Color(0xFFFC6E2A), size: 30),
                label: 'ร้านอาหาร',
              ),
              NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined, size: 28),
                selectedIcon: Icon(Icons.receipt_long,
                    color: Color(0xFFFC6E2A), size: 30),
                label: 'คำสั่งซื้อ',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle_outlined, size: 28),
                selectedIcon: Icon(Icons.account_circle,
                    color: Color(0xFFFC6E2A), size: 30),
                label: 'บัญชี',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
