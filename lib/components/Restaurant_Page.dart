import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/Card/CardRestaurantPage.dart';

class Restaurant_Page extends StatefulWidget {
  const Restaurant_Page({super.key});

  @override
  State<Restaurant_Page> createState() => _Restaurant_PageState();
}

class _Restaurant_PageState extends State<Restaurant_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ร้านค้า",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 60,
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
            CardRestaurantPage(
              imageAssets: "assets/padkapao.jpg",
              restaurantName: "ร้านเคี้ยงอร่อย",
              description: 'อาหารตามสั่ง - อาหารจานเดียว - ราคาประหยัด',
            ),
            SizedBox(
              height: 20,
            ),
            CardRestaurantPage(
              imageAssets: "assets/hoitod.jpg",
              restaurantName: "ร้านหอยทอดชาวเล",
              description: 'อาหารตามสั่ง - อาหารจานเดียว - ราคาประหยัด',
            ),
          ],
        ),
      ),
    );
  }
}

// New page for the restaurant details
