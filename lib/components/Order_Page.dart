import 'package:flutter/material.dart';

class Order_Page extends StatefulWidget {
  const Order_Page({super.key});

  @override
  State<Order_Page> createState() => _Order_PageState();
}

class _Order_PageState extends State<Order_Page> {
  final List<OrderStatus> statuses = [
    OrderStatus("ร้านอาหารรับออเดอร์แล้ว", true, false),
    OrderStatus("ร้านอาหารกำลังเตรียมอาหารของคุณ", false, false),
    OrderStatus("อาหารของคุณเสร็จแล้ว ไปรับที่หน้าร้านได้เลย", false, false),
    OrderStatus("คุณได้รับอาหารแล้ว ทานให้อร่อย", false, false),
  ];
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
                      "ติดตามคำสั่งซื้อ",
                      style: TextStyle(fontSize: 20, color: Color(0xFF181C2E)),
                    )
                  ],
                ),
                SizedBox(
                  width: 0,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "คำสั่งซื้อของคุณ",
              style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  width: 123,
                  height: 111,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/padkapao.jpg")),
                      borderRadius: BorderRadius.circular(25)),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ผัดกระเพราหมูสับ",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF181C2E)),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "x1",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF646982)),
                        ),
                      ],
                    ),
                    Text(
                      "ไข่ดาว",
                      style: TextStyle(fontSize: 15, color: Color(0xFF646982)),
                    ),
                    Text(
                      "ร้านใบเพรา",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF181C2E),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "สั่งเมื่อ : 11 .59 น. 9/11/67 ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF181C2E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "หมายเลขคำสั่งซื้อของคุณ :",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF181C2E),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "AOO1",
                  style: TextStyle(
                    fontSize: 50,
                    color: Color(0xFFFC6E2A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "สถานะคำสั่งซื้อ",
              style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(statuses.length, (index) {
                final status = statuses[index];
                final isLast = index == statuses.length - 1;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Icon(
                          status.isCompleted
                              ? Icons.check_circle
                              : Icons.radio_button_checked,
                          color: status.isActive
                              ? Color(0xFFFF7622)
                              : Color(0xFFB0B0B0),
                          size: 24,
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 40,
                            color: status.isActive
                                ? Color(0xFFFF7622)
                                : Color(0xFFB0B0B0),
                          ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        status.text,
                        style: TextStyle(
                          fontSize: 16,
                          color: status.isActive
                              ? Color(0xFFFF7622)
                              : Color(0xFFB0B0B0),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class OrderStatus {
  final String text;
  final bool isActive;
  final bool isCompleted;

  OrderStatus(this.text, this.isActive, this.isCompleted);
}
