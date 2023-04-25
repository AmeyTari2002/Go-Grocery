import 'package:flutter/material.dart';
import 'package:miniproject/pages/detailPage/components/second_part.dart';

import 'components/top_part.dart';

class DetailsPage extends StatelessWidget {
  final String productId;
  final String productImage;
  final String productName;
  final String productCategory;
  final double productPrice;
  final double productOldPrice;
  final String productDescription;
  final int productRate;

  const DetailsPage(
      {Key? key,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productOldPrice,
      required this.productRate,
        required this.productDescription, required this.productId, required this.productCategory
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(productId);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopPart(
              productImage: productImage  ,
            ),
            SecondPart(
              productCategory: productCategory,
              productName: productName,
              productPrice: productPrice,
              productOldPrice: productOldPrice,
              productRate: productRate,
              productDescription: productDescription, productId: productId, productImage: productImage,
            ),
          ],
        ),
      ),
    );
  }
}
