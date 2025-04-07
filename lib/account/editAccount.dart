import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:typed_data';
import 'package:localstorage/localstorage.dart';
import 'package:foodqueuedev/model/user_data.dart';
import 'dart:convert';

class EditAccount extends StatefulWidget {
  final String username;
  final Function fetchUser;
  final Function fetchProfile;
  final String description;
  final Future<Uint8List> imageProfileUrl;
  const EditAccount(
      {super.key,
      required this.description,
      required this.username,
      required this.imageProfileUrl,
      required this.fetchUser,
      required this.fetchProfile});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController description = TextEditingController();

  PlatformFile? objFile;
  String? filePath;
  List<UserData> user = [];

  Future<void> updateProfileData(String username, String description) async {
    try {
      final authToken = localStorage.getItem("token");
      var response = await http.put(
          Uri.parse("http://localhost:3000/user/profile/update"),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Bearer $authToken"
          },
          body: jsonEncode({
            "username": username,
            "description": description,
          }));
      if (response.statusCode == 200) {
        widget.fetchUser();
        widget.fetchProfile();
        Navigator.popUntil(context, (route) => route.isFirst);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('อัปเดตบัญชีสำเร็จ!'),
          backgroundColor: Colors.green,
        ));
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    }
  }

  void chooseFileUsingFilePicker() async {
    var result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        objFile = result.files.single;
        filePath = objFile!.path; // ใช้ path เพื่ออัปโหลดไฟล์
      });
    }
  }

  void uploadSelectedFile() async {
    if (objFile == null || objFile!.bytes == null) {
      print("ไม่สามารถอ่านไฟล์ได้");
      return;
    }
    final authToken = localStorage.getItem("token");
    var uri = Uri.parse("http://localhost:3000/upload");
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll({
      'Authorization': 'Bearer $authToken',
    });

    // ใช้ fromBytes แทน fromPath
    request.files.add(
      http.MultipartFile.fromBytes(
        "file",
        objFile!.bytes as Uint8List,
        filename: objFile!.name,
      ),
    );

    var response = await request.send();
    String result = await response.stream.bytesToString();
    print(result);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username.text = widget.username;
    description.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(25, 25, 25, 40),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                                color: Color(0xFFECF0F4),
                                shape: BoxShape.circle),
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
                          "แก้ไขบัญชี",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF181C2E)),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 48, 223, 165),
                                shape: BoxShape.circle),
                            child: objFile != null
                                ? ClipOval(
                                    child: Image.memory(
                                      objFile!.bytes!,
                                      fit: BoxFit.cover,
                                      width: 130,
                                      height: 130,
                                    ),
                                  )
                                : FutureBuilder<Uint8List>(
                                    future: widget.imageProfileUrl,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
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
                                                image:
                                                    MemoryImage(snapshot.data!),
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
                                  )),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 45,
                            height: 45,
                            padding: EdgeInsets.only(left: 7),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFB534),
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.mode_edit_outline_outlined,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 22,
                                ),
                                onPressed: chooseFileUsingFilePicker),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
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
                            controller: username,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     setState(() {
                            //       fullnameMassage = 'กรุณากรอกชื่อ-สกุล';
                            //     });
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "กรอกชื่อ-สกุล",
                              hintStyle: TextStyle(
                                  fontSize: 15, color: Color(0xFFA0A5BA)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // Container(
                        //     height: 20,
                        //     child: fullnameMassage != null
                        //         ? Text(
                        //             fullnameMassage!,
                        //             style: TextStyle(color: Colors.red, fontSize: 14),
                        //           )
                        //         : SizedBox.shrink()),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        Text(
                          'คำอธิบายตัวเอง',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 130,
                          padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFF0F5FA),
                          ),
                          child: TextFormField(
                            controller: description,
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter your name';
                            //   }
                            //   return null;
                            // },
                            // onChanged: validateEmail,
                            decoration: InputDecoration(
                              hintText: "example@gmail.com",
                              hintStyle: TextStyle(
                                  fontSize: 15, color: Color(0xFFA0A5BA)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ))
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFFFB534),
                minimumSize: Size(200, 62),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (objFile != null) {
                    uploadSelectedFile();
                  }
                  updateProfileData(username.text, description.text);
                }
              },

              // onPressed: () {
              //   // if (_formKey.currentState!.validate()) {
              //   //   register(fullname.text, email.text, password.text);
              //   // }
              // },
              child: Center(
                child: Text(
                  "บันทึก",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
