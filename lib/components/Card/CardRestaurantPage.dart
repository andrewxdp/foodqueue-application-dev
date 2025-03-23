import 'package:flutter/material.dart';
import 'package:foodqueuedev/components/RestaurantDetailPage.dart';

class CardRestaurantPage extends StatelessWidget {
  final String restaurantName, imageAssets, description;
  const CardRestaurantPage(
      {super.key,
      required this.imageAssets,
      required this.restaurantName,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 90,
              height: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imageAssets), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurantName,
                  style: TextStyle(fontSize: 18, color: Color(0xFF32343E)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'อาหารตามสั่ง - อาหารจานเดียว - ราคาประหยัด',
                  style: TextStyle(fontSize: 12, color: Color(0xFFA0A5BA)),
                ),
                SizedBox(
                  height: 10,
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
                        Icon(Icons.people_alt_outlined,
                            color: Color(0xFFFC6E2A)),
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
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 2,
          color: Color(0xFFEBEBEB),
        )
      ],
    );
  }
}
