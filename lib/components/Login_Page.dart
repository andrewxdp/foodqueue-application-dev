import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/Register_Page.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            color: Color(0xFF181C2E),
            child: Column(
              children: [
                SizedBox(
                  height: 110,
                ),
                Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'กรุณาเข้าสู่ระบบด้วยบัญชีที่คุณมีอยู่',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 220),
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'อีเมล',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFF0F5FA),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "กรอกอีเมล",
                      hintStyle:
                          TextStyle(fontSize: 15, color: Color(0xFFA0A5BA)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'รหัสผ่าน',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFF0F5FA),
                  ),
                  child: TextField(
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                        hintText: "กรอกรหัสผ่าน",
                        hintStyle:
                            TextStyle(fontSize: 15, color: Color(0xFFA0A5BA)),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFFB4B9CA),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        )),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: null),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "จดจำการเข้าสู่ระบบ",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFFA0A5BA)),
                        )
                      ],
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "ลืมรหัสผ่าน",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFFFFB534)),
                        ))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFFFB534),
                    minimumSize: Size(200, 62),
                  ),
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      "เข้าสู่ระบบ ",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ยังไม่มีบัญชี?",
                      style: TextStyle(fontSize: 18, color: Color(0xFFA0A5BA)),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return RegisterPage();
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                        child: Text('สมัครสมาชิก',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFB534))))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
