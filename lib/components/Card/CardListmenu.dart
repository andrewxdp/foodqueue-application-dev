import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/ProductDetails_Page.dart';

class CardListMenu extends StatelessWidget {
  final String imageAssets, productName;
  final double price;
  const CardListMenu(
      {super.key,
      required this.imageAssets,
      required this.price,
      required this.productName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ProductDetailsPage();
            },
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 190, 190, 190),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(imageAssets),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productName),
                        Text(
                          '${price} บาท',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return ProductDetailsPage();
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
              icon: Icon(Icons.add_circle, size: 40, color: Color(0xFFFC6E2A)),
            ),
          ),
        ],
      ),
    );
  }
}
