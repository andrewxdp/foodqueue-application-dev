import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String payment = "cash";

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
                      "ชำระเงิน ",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          payment = "cash";
                        });
                      },
                      child: Container(
                        width: 105,
                        height: 92,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F5FA),
                          borderRadius: BorderRadius.circular(15),
                          border: payment == 'cash'
                              ? Border.all(
                                  color: Color(0xFFFF7622), // Border color
                                  width: 3.0, // Border thickness
                                )
                              : null,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.money_sharp,
                            size: 50,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("เงินสด",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xFF464E57)))
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          payment = 'promtpay';
                        });
                      },
                      child: Container(
                        width: 105,
                        height: 92,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F5FA),
                          borderRadius: BorderRadius.circular(15),
                          border: payment == 'promtpay'
                              ? Border.all(
                                  color: Color(0xFFFF7622), // Border color
                                  width: 3.0, // Border thickness
                                )
                              : null,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.payment,
                            size: 50,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("พร้อมเพย์",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xFF464E57)))
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          payment = 'mobile banking';
                        });
                      },
                      child: Container(
                        width: 105,
                        height: 92,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F5FA),
                          borderRadius: BorderRadius.circular(15),
                          border: payment == 'mobile banking'
                              ? Border.all(
                                  color: Color(0xFFFF7622), // Border color
                                  width: 3.0, // Border thickness
                                )
                              : null,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.account_balance,
                            size: 50,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("ธนาคาร",
                        style:
                            TextStyle(fontSize: 17, color: Color(0xFF464E57)))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            payment == 'cash'
                ? Container(
                    padding: EdgeInsets.all(25),
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                        color: Color(0xFFF0F5FA),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/cash.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text("ชำระด้วยเงินสด",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF32343E),
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("ชำระเงินกับคนขายเมื่อไปรับอาหาร",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF2D2D2D),
                            )),
                      ],
                    ),
                  )
                : payment == 'promtpay'
                    ? Container(
                        padding: EdgeInsets.all(25),
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                            color: Color(0xFFF0F5FA),
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/promtpay.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(25),
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                            color: Color(0xFFF0F5FA),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/kungthai.jpg"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text("นาย ธีรกานต์ เพชรแอน",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF32343E),
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Text("702-0-31883-5",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF2D2D2D),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text("ชำระเงินผ่านธนาคารกรุงไทย",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF2D2D2D),
                                )),
                          ],
                        ),
                      ),
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text("จำนวนเงินทั้งหมด",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF32343E),
                    )),
                SizedBox(
                  width: 20,
                ),
                Text("60.00 บาท",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF2D2D2D),
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(
              height: 50,
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
                  "ยืนยันการชำระเงิน",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
