import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  bool passwordConfirmVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    passwordConfirmVisible = true;
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
                  'สมัครสมาชิก',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'กรุณาสมัครสมาชิกเพื่อเริ่มต้น',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 45,
            child: Container(
              width: 45,
              height: 45,
              padding: EdgeInsets.only(left: 7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF5E616F),
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
                  'ชื่อ - สกุล',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 65,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFF0F5FA),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "กรอกชื่อ-สกุล",
                      hintStyle:
                          TextStyle(fontSize: 15, color: Color(0xFFA0A5BA)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'อีเมล',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 65,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFF0F5FA),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "example@gmail.com",
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
                  height: 65,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
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
                Text(
                  'ยีนยันรหัสผ่าน',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 65,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFF0F5FA),
                  ),
                  child: TextField(
                    obscureText: passwordConfirmVisible,
                    decoration: InputDecoration(
                        hintText: "กรอกรหัสผ่าน",
                        hintStyle:
                            TextStyle(fontSize: 15, color: Color(0xFFA0A5BA)),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordConfirmVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFFB4B9CA),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                passwordConfirmVisible =
                                    !passwordConfirmVisible;
                              },
                            );
                          },
                        )),
                  ),
                ),
                SizedBox(
                  height: 60,
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
                      "สมัครสมาชิก",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
