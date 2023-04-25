import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/pages/home/home_page.dart';
import 'package:miniproject/widgets/my_button.dart';
import 'package:miniproject/widgets/single_cart_item.dart';

import '../routes/routing_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyButton(onPressed: () {
        RoutingPage.goTonext(
          context: context,
          navigateTo: HomePage(),
        );
      }, text: "BUY"),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("cart")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userCart")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (!streamSnapshot.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = streamSnapshot.data!.docs[index];
              return SingleCart(
                productImage: data["productImage"],
                productName: data["productName"],
                productPrice: data["productPrice"],
                productQuantity: data["productQuantity"],
                productId: data["productId"],
                productCategory: data["productCategory"],
              );
            },
          );
        },
      ),
    );
  }
}
