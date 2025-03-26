import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/Card/CardRestaurantHomePage.dart';
import 'package:foodqueuedev/components/Layout.dart';

class Homepage extends StatefulWidget {
  final PageController pageController;
  final String username;

  const Homepage({
    super.key,
    required this.pageController,
    required this.username,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
            Text(
              "โต๊ะของคุณ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF32343E),
              ),
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
                    Text(
                      "คุณยังไม่ได้จองโต๊ะ",
                      style: TextStyle(
                          color: Color(0xFF32343E),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
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
