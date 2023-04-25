import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/pages/cartPage/cart_page.dart';
import 'package:miniproject/pages/routes/routing_page.dart';

import '../../../appColors/app_colors.dart';
import '../../../widgets/my_button.dart';

class SecondPart extends StatelessWidget {
  final String productName;
  final double productPrice;
  final double productOldPrice;
  final int productRate;
  final String productDescription;
  final String productId;
  final String productImage;
  final String productCategory;
  const SecondPart(
      {Key? key,
      required this.productName,
      required this.productPrice,
      required this.productOldPrice,
      required this.productRate,
        required this.productDescription, required this.productId, required this.productImage, required this.productCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            children: [
              Text(
                "\₹$productPrice",
                style: TextStyle(
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "\₹$productOldPrice",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.gradient1,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        "$productRate",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "50 Reviews",
                    style: TextStyle(
                      color: AppColors.gradient1,
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
          Text(
            "Description",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("$productDescription"),
          MyButton(onPressed: () {
            FirebaseFirestore.instance
                .collection("cart")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("userCart")
                .doc(productId)
                .set(
                {
                  "productId": productId,
                  "productImage": productImage,
                  "productName": productName,
                  "productPrice": productPrice,
                  "productOldPrice": productPrice,
                  "productRate": productRate,
                  "productDescription": productDescription,
                  "productQuantity": 1,
                  "productCategory": productCategory,
                },
            );
            RoutingPage.goTonext(context: context, navigateTo: CartPage(),);
          }, text: "Add to Cart"),
        ],
      ),
    );
  }
}
