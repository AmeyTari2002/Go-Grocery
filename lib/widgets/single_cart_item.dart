import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingleCart extends StatefulWidget {
  final String productImage;
  final String productName;
  final double productPrice;
  final int productQuantity;
  final String productId;
  final String productCategory;
  const SingleCart(
      {Key? key,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productQuantity,
      required this.productId,
        required this.productCategory})
      : super(key: key);

  @override
  State<SingleCart> createState() => _SingleCartState();
}

class _SingleCartState extends State<SingleCart> {
  int quantity = 1;

  void quantityFuntion() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .update({
      "productQuantity": quantity,
    });
  }

  void deleteProductFuntion() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .delete();
  }
  @override
  Widget build(BuildContext context) {
    print(quantity);
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 7)
      ]),
      child: Stack(
        alignment:  Alignment.topRight,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                    image: NetworkImage(widget.productImage),
                  )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.productCategory,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "\₹${widget.productPrice * widget.productQuantity}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncrementAndDecrement(
                            onPressed: () {
                              setState(() {
                                quantity++;
                                quantityFuntion();
                              });
                            },
                            icon: Icons.add,
                          ),
                          Text(widget.productQuantity.toString(),style: TextStyle(
                            fontSize: 18,
                          ),),
                          IncrementAndDecrement(
                            onPressed: () {
                              if(quantity>1){

                                setState(() {
                                  quantity--;
                                  quantityFuntion();
                                });
                              };
                              },

                            icon: Icons.remove,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          IconButton(onPressed: () {
            deleteProductFuntion();
          }, icon: Icon(
            Icons.close,
          ),
          )
        ],
      ),
    );
  }
}

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  const IncrementAndDecrement(
      {Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 40,
      height: 30,
      elevation: 2,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Icon(icon),
    );
  }
}
