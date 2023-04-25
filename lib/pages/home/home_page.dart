import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/pages/detailPage/details_page.dart';
import 'package:miniproject/widgets/grid_view_widget.dart';
import 'package:miniproject/widgets/single_product.dart';
//import '../../widgets/single_product.dart';
import '../cartPage/cart_page.dart';
import '../login/login_page.dart';
import '../profile/profile_page.dart';
import '../routes/routing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name = '';
  String? email = '';
  String? userid = '';

  Future _getDataFromDatabse() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["fullname"];
          email = snapshot.data()!["emailAddress"];
          userid = snapshot.data()!["userUid"];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDatabse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              accountName: Text(
                'Userid:${name!}',
                style: const TextStyle(fontSize: 20),
              ),
              accountEmail: Text('Email :${email!}',
                  style: const TextStyle(fontSize: 12)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/id.png"),
              ),
            ),
            ListTile(
              onTap: () {
                RoutingPage.goTonext(
                  context: context,
                  navigateTo: ProfilePage(),
                );
              },
              leading: Icon(
                Icons.person,
              ),
              title: Text("Profile"),
            ),
            ListTile(
                onTap: () {
                  RoutingPage.goTonext(
                    context: context,
                    navigateTo: CartPage(),
                  );
                },
              leading: Icon(
                Icons.shopping_cart_rounded,
              ),
              title: Text("Cart"),
            ),
            ListTile(
              //   onTap: () {
              //     RoutingPage.goTonext(
              //       context: context,
              //       navigateTo: FavoritePage(),
              //     );
              //   },
              leading: Icon(
                Icons.favorite,
              ),
              title: Text("Favorite"),
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.shopping_basket_sharp,
            //   ),
            //   title: Text("My Order"),
            // ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut().then(
                      (value) => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      ),
                    );
              },
              leading: Icon(
                Icons.exit_to_app,
              ),
              title: Text("Log out"),
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
      ),
      body: ListView(
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
          ListTile(
            leading: Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

          Container(
            height: 120,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("categories")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return Center(child: const CircularProgressIndicator());
                }
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Categories(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GridViewWidget(
                                collection: streamSnapshot.data!.docs[index]
                                    ["categoryName"],
                                id: streamSnapshot.data!.docs[index].id,
                              ),
                            ),
                          ); // categories on tap

                          print("Print");
                        },
                        image: streamSnapshot.data!.docs[index]
                            ["categoryImage"],
                        categoryName: streamSnapshot.data!.docs[index]
                            ["categoryName"],
                      );
                    });
              },
            ),
          ),

          // SingleChildScrollView(
          //   physics: const BouncingScrollPhysics(),
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: [
          //       Categories(
          //         image: "assets/images/fruits.png",
          //         categoryName: 'Fruits',
          //       ),
          //       Categories(
          //         image: 'assets/images/vegetable.png',
          //         categoryName: 'Vegetable',
          //       ),
          //       Categories(
          //         image: 'assets/images/fruits.png',
          //         categoryName: 'Dairy',
          //       ),
          //       Categories(
          //         image: 'assets/images/fruits.png',
          //         categoryName: 'Bread and Bakery',
          //       ),
          //     ],
          //   ),
          // ),
          ListTile(
            leading: Text(
              "Product",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[800],
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            height: 280,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return Center(child: const CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = streamSnapshot.data!.docs[index];
                    return SingleProduct(
                      onTap: () {
                        RoutingPage.goTonext(context: context, navigateTo: DetailsPage(
                          productImage: data["productImage"],
                          productName: data["productName"],
                          productPrice: data["productPrice"],
                          productOldPrice:data["productOldPrice"],
                          productRate: data["productRate"],
                          productDescription: data["productDescription"], productId: data["productId"], productCategory: data["productCategory"],
                        ),);
                      },
                        image: streamSnapshot.data!.docs[index]["productImage"],
                        price: streamSnapshot.data!.docs[index]["productPrice"],
                        name: streamSnapshot.data!.docs[index]["productName"],
                      );

                    //   return Categories(
                    //     onTap: () {
                    //
                    //     },
                    //     image: streamSnapshot.data!.docs[index]
                    //     ["categoryImage"],
                    //     categoryName: streamSnapshot.data!.docs[index]
                    //     ["categoryName"],
                    //   );
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: Text(
              "Best Sell",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[800],
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            height: 280,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("products")
                  .where("productRate", isGreaterThan: 4)
                  .orderBy(
                    "productRate",
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (!streamSnapshot.hasData) {
                  return Center(child: const CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return SingleProduct(
                        onTap: () {
                          RoutingPage.goTonext(context: context, navigateTo: DetailsPage(
                            productCategory: streamSnapshot.data!.docs[index]["productCategory"],
                            productImage: streamSnapshot.data!.docs[index]["productImage"],
                            productName: streamSnapshot.data!.docs[index]["productName"],
                            productPrice: streamSnapshot.data!.docs[index]["productPrice"],
                            productOldPrice:streamSnapshot.data!.docs[index]["productOldPrice"],
                            productRate: streamSnapshot.data!.docs[index]["productRate"],
                            productDescription: streamSnapshot.data!.docs[index]["productDescription"],
                              productId: streamSnapshot.data!.docs[index]["productId"],
                          ),);

                        },
                        image: streamSnapshot.data!.docs[index]["productImage"],
                        price: streamSnapshot.data!.docs[index]["productPrice"],
                        name: streamSnapshot.data!.docs[index]["productName"]);

                    //   return Categories(
                    //     onTap: () {
                    //
                    //     },
                    //     image: streamSnapshot.data!.docs[index]
                    //     ["categoryImage"],
                    //     categoryName: streamSnapshot.data!.docs[index]
                    //     ["categoryName"],
                    //   );
                  },
                );
              },
            ),
          ),
          // SingleChildScrollView(
          //   physics: const BouncingScrollPhysics(),
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: [
          //       // SingleProduct(),
          //       // SingleProduct(),
          //       // SingleProduct(),
          //       // SingleProduct(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String image;
  final String categoryName;
  final Function()? onTap;
  const Categories(
      {Key? key,
      required this.image,
      required this.categoryName,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(12.0),
        height: 120,
        width: 160,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              image,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.6),
            // gradient: LinearGradient(
            //   begin: Alignment.center,
            //   colors: [
            //     Colors.black.withOpacity(0.6),
            //     Colors.black.withOpacity(0.6),
            //   ]
            //
            // ),
          ),
          child: Center(
            child: Text(categoryName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
