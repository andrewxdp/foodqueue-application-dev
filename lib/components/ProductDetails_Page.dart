import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool? isChecked_1 = false;
  bool? isChecked_2 = false;
  List addEgg = [];
  String sizeProduct = 'Regular';
  int quantity = 1;
  int price = 50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(25, 40, 25, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/padkapao.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15))),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "ผัดกระเพราหมูสับ",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF181C2E),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "\u00A0\u00A0 หอยทอดออส่วนคือเมนูผัดหอยนางรมกับแป้งและไข่ เนื้อนุ่ม เสิร์ฟพร้อมถั่วงอกและน้ำจิ้ม",
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
                            "4.7",
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
                            "4.7",
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
                  Row(
                    children: [
                      Text(
                        "ขนาด :",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF181C2E),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sizeProduct = "Regular";
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          decoration: BoxDecoration(
                              color: sizeProduct == 'Regular'
                                  ? Color(0xFFFC6E2A)
                                  : Color(0xFFF0F5FA),
                              shape: BoxShape.circle),
                          child: Text(
                            "ปกติ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: sizeProduct == 'Regular'
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: sizeProduct == 'Regular'
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sizeProduct = "Special";
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          decoration: BoxDecoration(
                              color: sizeProduct == 'Special'
                                  ? Color(0xFFFC6E2A)
                                  : Color(0xFFF0F5FA),
                              shape: BoxShape.circle),
                          child: Text(
                            "พิเศษ",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: sizeProduct == 'Special'
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: sizeProduct == 'Special'
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      )
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
                          Text(
                            "เพิ่มไข่ :",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF181C2E),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked_1,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked_1 = value;

                                        if (isChecked_1 == true) {
                                          price += 13;
                                          addEgg.add('ไข่ดาว');
                                          print(addEgg);
                                        } else {
                                          price -= 13;
                                          addEgg.remove('ไข่ดาว');
                                          print(addEgg);
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'ไข่ดาว',
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Text("+13", style: TextStyle(fontSize: 18))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 84,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked_2,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked_2 = value;
                                        if (isChecked_2 == true) {
                                          price += 10;
                                          addEgg.add('ไข่เจียว');
                                        } else {
                                          price -= 10;
                                          addEgg.remove('ไข่เจียว');
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'ไข่เจียว',
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Text("+10", style: TextStyle(fontSize: 18))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(25),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Color(0xFFECF0F4), shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
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
                    "ผัดกระเพราหมูสับ",
                    style: TextStyle(fontSize: 20, color: Color(0xFF181C2E)),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 160,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFFBF6EE),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 190, 190, 190),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${price * quantity} บาท",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 150,
                        height: 60,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFFECF0F4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantity == 1) {
                                      quantity = 1;
                                    } else {
                                      quantity--;
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_circle,
                                  size: 30,
                                )),
                            Text(
                              "$quantity",
                              style: TextStyle(fontSize: 20),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                icon: Icon(
                                  Icons.add_circle,
                                  size: 30,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFFC6E2A),
                      minimumSize: Size(200, 50),
                    ),
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        "ชำระเงินเลย",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
