import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/Card/CardRestaurantPage.dart';
import 'package:foodqueuedev/components/RestaurantDetailPage.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:foodqueuedev/model/restaurant_data.dart';

class Restaurant_Page extends StatefulWidget {
  const Restaurant_Page({super.key});

  @override
  State<Restaurant_Page> createState() => _Restaurant_PageState();
}

class _Restaurant_PageState extends State<Restaurant_Page> {
  List<RestaurantData> restaurant = [];

  Future<void> fetchRestaurant() async {
    try {
      final authToken = localStorage.getItem("token");
      var response = await http.get(
          Uri.parse("http://localhost:3000/restaurant"),
          headers: {"authorization": "Bearer $authToken"});
      if (!mounted) return;
      if (response.statusCode == 200) {
        var restaurantData = jsonDecode(response.body);

        if (restaurantData is List && restaurantData.isNotEmpty) {
          setState(() {
            restaurant = restaurantData
                .map((restaurant) => RestaurantData.fromJson(restaurant))
                .toList();
          });
        }
      }
    } catch (error) {
      if (!mounted) return;
      print(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRestaurant();
  }

  dynamic onClick_Restaurant(RestaurantData restaurant) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return RestaurantDetailsPage(
            restaurant: restaurant,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

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
            ...List.generate(restaurant.length, (i) {
              return GestureDetector(
                onTap: () {
                  onClick_Restaurant(restaurant[i]);
                },
                child: CardRestaurantPage(
                    restaurantName: restaurant[i].nameRestaurantTH,
                    description: restaurant[i].title,
                    rating: restaurant[i].rating,
                    time: restaurant[i].time,
                    customer: restaurant[i].customer),
              );
            })
          ],
        ),
      ),
    );
  }
}

// New page for the restaurant details
