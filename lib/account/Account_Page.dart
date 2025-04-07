import 'dart:typed_data';
import 'package:foodqueuedev/components/Login_Page.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:foodqueuedev/account/aboutAccout.dart';

class Account_Page extends StatefulWidget {
  final String username;
  final String email;
  final Future<Uint8List> imageProfileUrl;
  final String description;
  final Function fetchUser;
  final Function fetchProfile;

  const Account_Page(
      {super.key,
      required this.email,
      required this.username,
      required this.imageProfileUrl,
      required this.description,
      required this.fetchUser,
      required this.fetchProfile});

  @override
  State<Account_Page> createState() => _Account_PageState();
}

class _Account_PageState extends State<Account_Page> {
  Future<void> logOut() async {
    try {
      localStorage.removeItem("token");
      localStorage.removeItem("isLogin");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login_Page()),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print("LogOut error: $error");
    }
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
              "บัญชีของฉัน",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
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
                      style: TextStyle(fontSize: 20, color: Color(0xFF32343E)),
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
              child: Row(
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
                      Text(
                        "เกี่ยวกับบัญชี",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF32343E)),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return AboutAccount(
                              email: widget.email,
                              username: widget.username,
                              imageProfileUrl: widget.imageProfileUrl,
                              description: widget.description,
                              fetchUser: widget.fetchUser,
                              fetchProfile: widget.fetchProfile,
                            );
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
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: Color(0xFF32343E),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(0xFFF6F8FA),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
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
                          Icons.logout,
                          color: Color.fromARGB(255, 226, 1, 1),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "ออกจากระบบ",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF32343E)),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                            'คุณต้องการออกจากระบบ?',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                logOut();
                              },
                              child: const Text('ตกลง'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'ยกเลิก'),
                              child: const Text('ยกเลิก'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: Color(0xFF32343E),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
