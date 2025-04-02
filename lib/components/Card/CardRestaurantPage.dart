import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/RestaurantDetailPage.dart';
import 'package:localstorage/localstorage.dart';

class CardRestaurantPage extends StatefulWidget {
  final String restaurantName, description, time, rating, customer;

  const CardRestaurantPage(
      {super.key,
      required this.restaurantName,
      required this.description,
      required this.customer,
      required this.rating,
      required this.time});

  @override
  State<CardRestaurantPage> createState() => _CardRestaurantPageState();
}

class _CardRestaurantPageState extends State<CardRestaurantPage> {
  late Future<Uint8List> logo;
  Future<Uint8List> fetchRestaurantLogo() async {
    final authToken = localStorage.getItem("token");
    final response =
        await http.post(Uri.parse('http://localhost:3000/restaurant/logo'),
            headers: {
              "Content-Type": "application/json",
              "authorization": "Bearer $authToken",
            },
            body: jsonEncode({"restaurantNameTH": widget.restaurantName}));
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            FutureBuilder<Uint8List>(
              future: logo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  if (snapshot.data is Uint8List) {
                    return Container(
                      width: 90,
                      height: 80,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: MemoryImage(snapshot.data!),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15)),
                    );
                  } else {
                    return Text('Invalid image data');
                  }
                } else {
                  return Text('No image available');
                }
              },
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurantName,
                  style: TextStyle(fontSize: 18, color: Color(0xFF32343E)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 12, color: Color(0xFFA0A5BA)),
                ),
                SizedBox(
                  height: 10,
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
                          widget.rating,
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
                          widget.time,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Row(
                      children: [
                        Icon(Icons.people_alt_outlined,
                            color: Color(0xFFFC6E2A)),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.customer,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 2,
          color: Color(0xFFEBEBEB),
        )
      ],
    );
  }
}
