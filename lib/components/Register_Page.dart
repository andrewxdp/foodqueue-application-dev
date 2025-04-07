import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm_password = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  bool passwordVisible = false;
  bool passwordConfirmVisible = false;
  String? passwordMassage;
  Color? passwordColorMessage;
  String? emailMassage;
  Color? emailColorMessage;
  bool? matchPassword;
  String? passwordConfirmMassage;
  String? fullnameMassage;

  void validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        emailMassage = "กรุณากรอกอีเมล";
        emailColorMessage = Colors.red;
      });
      return;
    }

    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

    setState(() {
      if (emailRegex.hasMatch(value)) {
        emailMassage = "รูปแบบถูกต้อง";
        emailColorMessage = Colors.green;
      } else {
        emailMassage = "อีเมลต้องมีรูปแบบ example@gmail.com";
        emailColorMessage = Colors.red;
      }
    });
  }

  void validateConfirmPassword(String value) {
    setState(() {
      if (value != password.text) {
        passwordConfirmMassage = 'รหัสผ่านตรงกันไม่ตรงกัน';
        matchPassword = false;
      } else if (value == password.text) {
        passwordConfirmMassage = "รหัสผ่านตรงกัน";
        matchPassword = true;
      } else {
        passwordConfirmMassage = null;
      }
    });
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        passwordMassage = "กรุณากรอกรหัสผ่าน";
        passwordColorMessage = Colors.red; // สีแดงถ้าไม่ได้กรอก
      });
      return;
    }

    final passwordRegex = RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$", // ต้องมีตัวเลขและตัวอักษรอย่างน้อย 8 ตัว
    );

    setState(() {
      if (passwordRegex.hasMatch(value)) {
        passwordMassage = "รหัสผ่านรูปแบบถูกต้อง";
        passwordColorMessage = Colors.green;
      } else {
        passwordMassage = "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร และมีตัวเลข";
        passwordColorMessage = Colors.red;
      }
    });
  }

  Future<void> register(fullname, email, password) async {
    try {
      var response = await http.post(
          Uri.parse("http://localhost:3000/register"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(
              {"username": fullname, "email": email, "password": password}));
      if (response.statusCode == 201) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('สมัครสมาชิกสำเร็จ'),
          backgroundColor: Colors.green,
        ));
      } else {
        throw Exception("Failed to create user");
      }
    } catch (error) {
      print(error);
    }
  }

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
            child: Form(
              key: _formKey,
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
                    child: TextFormField(
                      controller: fullname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            fullnameMassage = 'กรุณากรอกชื่อ-สกุล';
                          });
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "กรอกชื่อ-สกุล",
                        hintStyle:
                            TextStyle(fontSize: 15, color: Color(0xFFA0A5BA)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 20,
                      child: fullnameMassage != null
                          ? Text(
                              fullnameMassage!,
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            )
                          : SizedBox.shrink()),
                  SizedBox(
                    height: 15,
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
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: validateEmail,
                      decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        hintStyle:
                            TextStyle(fontSize: 15, color: Color(0xFFA0A5BA)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 20,
                      child: emailMassage != null
                          ? Text(
                              emailMassage!,
                              style: TextStyle(
                                  color: emailColorMessage, fontSize: 14),
                            )
                          : SizedBox.shrink()),
                  SizedBox(
                    height: 15,
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
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                      onChanged: validatePassword,
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
                    height: 5,
                  ),
                  Container(
                      height: 20,
                      child: passwordMassage != null
                          ? Text(
                              passwordMassage!,
                              style: TextStyle(
                                  color: passwordColorMessage, fontSize: 14),
                            )
                          : SizedBox.shrink()),
                  SizedBox(
                    height: 15,
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
                    child: TextFormField(
                      controller: confirm_password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }

                        return null;
                      },
                      onChanged: validateConfirmPassword,
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
                    height: 10,
                  ),
                  Container(
                      height: 20,
                      child: matchPassword != null
                          ? (matchPassword == true
                              ? Text(
                                  passwordConfirmMassage!,
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 14),
                                )
                              : Text(
                                  passwordConfirmMassage!,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ))
                          : SizedBox.shrink()),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFFFB534),
                      minimumSize: Size(200, 62),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        register(fullname.text, email.text, password.text);
                      }
                    },
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
          ),
        ],
      ),
    );
  }
}
