import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/ProductDetails_Page.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class CardListMenu extends StatefulWidget {
  final String menu;
  final String restaurant;
  final String productName;
  final double price;
  const CardListMenu(
      {super.key,
      required this.price,
      required this.productName,
      required this.menu,
      required this.restaurant});

  @override
  State<CardListMenu> createState() => _CardListMenuState();
}

class _CardListMenuState extends State<CardListMenu> {
  late Future<Uint8List> image;
  Future<Uint8List> fetchRestaurantLogo() async {
    final authToken = localStorage.getItem("token");
    final response = await http.post(
        Uri.parse('http://localhost:3000/restaurant/menu/image'),
        headers: {
          "Content-Type": "application/json",
          "authorization": "Bearer $authToken",
        },
        body: jsonEncode(
            {"name": widget.menu, "nameRestaurantEng": widget.restaurant}));
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
    image = fetchRestaurantLogo();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
            ],
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<Uint8List>(
                future: image,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    if (snapshot.data is Uint8List) {
                      return Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: MemoryImage(snapshot.data!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Text('Invalid image data');
                    }
                  } else {
                    return Text('No image available');
                  }
                },
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.productName),
                      Text(
                        '${widget.price} บาท',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation, secondaryAnimation) {
              //       return ProductDetailsPage(menu: ,);
              //     },
              //     transitionDuration: const Duration(milliseconds: 300),
              //     transitionsBuilder:
              //         (context, animation, secondaryAnimation, child) {
              //       const begin = Offset(1.0, 0.0);
              //       const end = Offset.zero;
              //       const curve = Curves.easeInOut;

              //       var tween = Tween(begin: begin, end: end)
              //           .chain(CurveTween(curve: curve));
              //       var offsetAnimation = animation.drive(tween);

              //       return SlideTransition(
              //           position: offsetAnimation, child: child);
              //     },
              //   ),
              // );
            },
            icon: Icon(Icons.add_circle, size: 40, color: Color(0xFFFC6E2A)),
          ),
        ),
      ],
    );
  }
}
