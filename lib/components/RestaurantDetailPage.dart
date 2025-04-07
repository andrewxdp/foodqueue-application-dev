import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/Card/CardListmenu.dart';
import 'package:foodqueuedev/components/ProductDetails_Page.dart';
import 'package:foodqueuedev/model/restaurant_data.dart';
import 'package:localstorage/localstorage.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final RestaurantData restaurant;
  const RestaurantDetailsPage({super.key, required this.restaurant});

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  late Future<Uint8List> logo;
  Future<Uint8List> fetchRestaurantLogo() async {
    final authToken = localStorage.getItem("token");
    final response = await http.post(
        Uri.parse('http://localhost:3000/restaurant/logo'),
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer $authToken",
        },
        body: jsonEncode(
            {"restaurantNameTH": widget.restaurant.nameRestaurantTH}));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logo = fetchRestaurantLogo();
  }

  dynamic onClick_Product(MenuData menu) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProductDetailsPage(
            menu: menu,
            restaurant: widget.restaurant.nameRestaurantEng,
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
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(25, 40, 25, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Color(0xFFECF0F4), shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 15,
                          color: Color(0xFF181C2E),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "ดูร้านค้า",
                      style: TextStyle(fontSize: 20, color: Color(0xFF181C2E)),
                    )
                  ],
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color(0xFFECF0F4), shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 25,
                      color: Color(0xFF181C2E),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder<Uint8List>(
              future: logo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  if (snapshot.data is Uint8List) {
                    return Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(snapshot.data!),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.circular(15)));
                  } else {
                    return Text('Invalid image data');
                  }
                } else {
                  return Text('No image available');
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              widget.restaurant.nameRestaurantTH,
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF181C2E),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\u00A0\u00A0${widget.restaurant.description}",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFA0A5BA),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.star_border, color: Color(0xFFFC6E2A)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.restaurant.rating,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Color(0xFFFC6E2A)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.restaurant.time,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Row(
                  children: [
                    Icon(Icons.people_alt_outlined, color: Color(0xFFFC6E2A)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.restaurant.customer,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 2,
              color: Color(0xFFEBEBEB),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "รายการอาหาร",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF181C2E),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  ...List.generate(widget.restaurant.menuData.length, (i) {
                    return GestureDetector(
                      onTap: () {
                        onClick_Product(widget.restaurant.menuData[i]);
                      },
                      child: CardListMenu(
                          menu: widget.restaurant.menuData[i].name as String,
                          restaurant: widget.restaurant.nameRestaurantEng,
                          price: widget.restaurant.menuData[i].price as double,
                          productName:
                              widget.restaurant.menuData[i].name as String),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
