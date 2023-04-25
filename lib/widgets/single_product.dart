import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final double price;
  final String name;
  final Function()? onTap;

  const SingleProduct(
      {Key? key, required this.image,
        required this.price,
        required this.name,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 200,
            width: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                  image: NetworkImage(image),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "₹$price",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

              ],
            ),
        ],
      ),
    );
  }
}
