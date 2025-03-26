import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:foodqueuedev/account/editAccount.dart';

class AboutAccount extends StatefulWidget {
  final String username;
  final String email;
  final Function fetchUser;
  final Function fetchProfile;
  final Future<Uint8List> imageProfileUrl;
  final String description;

  const AboutAccount(
      {super.key,
      required this.email,
      required this.username,
      required this.description,
      required this.imageProfileUrl,
      required this.fetchUser,
      required this.fetchProfile});

  @override
  State<AboutAccount> createState() => _AboutAccountState();
}

class _AboutAccountState extends State<AboutAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(25),
        color: Colors.white,
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
                      width: 20,
                    ),
                    Text(
                      "เกี่ยวกับบัญชี",
                      style: TextStyle(fontSize: 20, color: Color(0xFF181C2E)),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return EditAccount(
                                description: widget.description,
                                username: widget.username,
                                imageProfileUrl: widget.imageProfileUrl,
                                fetchUser: widget.fetchUser,
                                fetchProfile: widget.fetchProfile);
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                                position: offsetAnimation, child: child);
                          },
                        ),
                      );
                    },
                    child: Text("แก้ไข",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFB6F3D),
                          decoration:
                              TextDecoration.underline, // Underline text
                          decorationColor:
                              Color(0xFFFB6F3D), // Color of the underline
                          decorationThickness: 1,
                        )))
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                FutureBuilder<Uint8List>(
                  future: widget.imageProfileUrl,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      if (snapshot.data is Uint8List) {
                        return Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
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
                SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF32343E),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 14, color: Color(0xFFA0A5BA)),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(0xFFF6F8FA),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: Color(0xFFFB6F3D),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ชื่อ นามสกุล",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF32343E),
                                  )),
                              Text(widget.username,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6B6E82),
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.email_outlined,
                              color: Color.fromARGB(255, 9, 12, 221),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("EMAIL",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF32343E),
                                  )),
                              Text(widget.email,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6B6E82),
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
