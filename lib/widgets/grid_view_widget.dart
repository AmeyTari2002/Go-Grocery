import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/widgets/single_product.dart';

import '../pages/detailPage/details_page.dart';
import '../pages/routes/routing_page.dart';

class GridViewWidget extends StatelessWidget {
  final String id;
  final String collection;

  const GridViewWidget({Key? key, required this.id, required this.collection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("categories")
              .doc(id)
              .collection(collection)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshort) {
            if(!snapshort.hasData){
              return Center(child: CircularProgressIndicator(),);
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 7,
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white70,
                          hintText: "Search Your Product",
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshort.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.4,    //image overflow error
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    var data = snapshort.data!.docs[index];
                    return SingleProduct(
                      onTap: () {
                        RoutingPage.goTonext(context: context, navigateTo: DetailsPage(
                        productImage: data["productImage"],
                          productId: data["productId"],
                        productName: data["productName"],
                        productPrice: data["productPrice"],
                        productOldPrice:data["productOldPrice"],
                        productRate: data["productRate"],
                          productDescription:data["productDescription"], productCategory: data["productCategory"],
                        ),);},
                      image: data["productImage"],
                      name: data["productName"],
                      price: data["productPrice"],
                    );
                  },
                ),
              ],
            );
          }),
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Material(
      //         elevation: 7,
      //         child: TextField(
      //           decoration: InputDecoration(
      //               fillColor: Colors.white70,
      //               hintText: "Search Your Product",
      //               filled: true,
      //               border: OutlineInputBorder(
      //                 borderSide: BorderSide.none,
      //               )),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
