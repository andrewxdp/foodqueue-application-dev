import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/Card/CardRestaurantHomePage.dart';
import 'package:foodqueuedev/components/Layout.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:async';

class Homepage extends StatefulWidget {
  final PageController pageController;
  final String username;
  final Function deleteTable;
  const Homepage(
      {super.key,
      required this.pageController,
      required this.username,
      required this.deleteTable});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? selectedTable;
  bool isLoading = true;
  int _minutes = 30;
  int _seconds = 0;
  late Timer _timer;
  Future<void> fetchTableNumber() async {
    try {
      final authToken = localStorage.getItem("token");
      var response = await http.get(
          Uri.parse("http://localhost:3000/table/selected/get"),
          headers: {"authorization": "Bearer $authToken"});
      if (response.statusCode == 200) {
        var tableNumber = jsonDecode(response.body);

        if (tableNumber.isNotEmpty) {
          setState(() {
            selectedTable = tableNumber["selectedTable"];
            isLoading = false;
          });
        } else {
          throw Exception("can't fetch table number");
        }
      } else {
        throw Exception("${response.statusCode}");
      }
    } catch (error) {
      setState(() {
        selectedTable = null;
      });
      print("Error fetching table number");
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        _timer.cancel();
        return;
      }

      if (_minutes == 0 && _seconds == 0) {
        _timer.cancel();
        widget.deleteTable();
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
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    initLocalStorage();
    fetchTableNumber();

    _minutes = int.parse(localStorage.getItem("minute") ?? "30");
    _seconds = int.parse(localStorage.getItem("second") ?? "0");
    _startTimer();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.location_on,
                      color: Color(0xFFFFA027),
                      size: 50,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "โรงอาหารเพชรรัตน์",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFC6E2A),
                          ),
                        ),
                        Text(
                          "มหาวิทยาลัยศิลปากร จ.นครปฐม",
                          style: TextStyle(color: Color(0xFF676767)),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF181C2E),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.username.isNotEmpty
                      ? "สวัสดี ${widget.username},"
                      : "กำลังโหลด...",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  " ขอให้สนุกกับการทาน!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.search, color: Color(0xFFA0A5BA)),
                  SizedBox(
                    width: 10,
                  ),
                  Text("ค้นหา ชื่ออาหาร , ร้านอาหาร",
                      style: TextStyle(color: Color(0xFF676767)))
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "โต๊ะของคุณ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF32343E),
                  ),
                ),
                selectedTable != null
                    ? Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            text: 'เวลาในการจอง ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              color: Color(0xFFFC6E2A),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ' นาที',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ))
                    : SizedBox(
                        width: 10,
                      )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 190, 190, 190),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ]),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selectedTable != null
                        ? Text(
                            " $selectedTable",
                            style: TextStyle(
                                color: Color(0xFFFC6E2A),
                                fontSize: 64,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "คุณยังไม่ได้จองโต๊ะ",
                            style: TextStyle(
                                color: Color(0xFF32343E),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                    selectedTable != null
                        ? Text(
                            "แถวที่ ${selectedTable!.substring(0, 1)} คอลัมน์ ${selectedTable!.substring(1, 2)} ",
                            style: TextStyle(
                                color: Color(0xFF32343E),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        : TextButton(
                            onPressed: () {
                              widget.pageController.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              "จองโต๊ะเลย >",
                              style: TextStyle(
                                color: Color(0xFFFC6E2A),
                                fontSize: 16,
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ร้านอาหารแนะนำ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF32343E),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "ดูทั้งหมด >",
                      style: TextStyle(fontSize: 16, color: Color(0xFF676767)),
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Card_restaurant_homepage(
              restaurantName: "เคี้ยงอร่อย",
              description: "อาหารตามสั่ง - อาหารจานเดียว - ราคาประหยัด",
              imageAssets: "assets/padkapao.jpg",
            ),
            SizedBox(
              height: 30,
            ),
            Card_restaurant_homepage(
              restaurantName: "เคี้ยงอร่อย",
              description: "อาหารตามสั่ง - อาหารจานเดียว - ราคาประหยัด",
              imageAssets: "assets/hoitod.jpg",
            ),
          ],
        ),
      ),
    );
  }
}
