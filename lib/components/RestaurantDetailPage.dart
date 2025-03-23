import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/Card/CardListmenu.dart';
import 'package:foodqueuedev/components/ProductDetails_Page.dart';

class RestaurantDetailsPage extends StatefulWidget {
  const RestaurantDetailsPage({super.key});

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  dynamic onClick_Product() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProductDetailsPage();
        },
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

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
                      "ดูร้านค้า",
                      style: TextStyle(fontSize: 20, color: Color(0xFF181C2E)),
                    )
                  ],
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color(0xFFECF0F4), shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 25,
                      color: Color(0xFF181C2E),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
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
              height: 30,
            ),
            Text(
              "ร้านเคี้ยงอร่อย",
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF181C2E),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\u00A0\u00A0ร้านหอยทอดชื่อดังทีเด็ดคือการที่ร้านทำหอยทอดกระทะยักษ์ แป้งกรอบ หอยทอดเครื่องแน่น ร้านนี้เปิดให้บริการมานานกว่า 45 ปีแล้ว สายสตรีทฟู้ดไม่ควรพลาดจ้า!",
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
                SizedBox(
                  width: 30,
                ),
                Row(
                  children: [
                    Icon(Icons.people_alt_outlined, color: Color(0xFFFC6E2A)),
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
            Text(
              "รายการอาหาร",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF181C2E),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      onClick_Product();
                    },
                    child: CardListMenu(
                        imageAssets: "assets/padkapao.jpg",
                        price: 50.0,
                        productName: "ผัดกระเพราหมูสับ"),
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
