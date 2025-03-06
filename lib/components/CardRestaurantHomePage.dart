import 'package:flutter/material.dart';

class Card_restaurant_homepage extends StatelessWidget {
  final String restaurantName, description, imageAssets;
  const Card_restaurant_homepage(
      {super.key,
      required this.restaurantName,
      required this.description,
      required this.imageAssets});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageAssets), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15)),
        ),
        SizedBox(
          height: 15,
        ),
        Text(restaurantName, style: TextStyle(fontSize: 20)),
        SizedBox(
          height: 5,
        ),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Color(0xFFA0A5BA)),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            SizedBox(
              width: 20,
            )
          ],
        )
      ],
    );
    ;
  }
}
