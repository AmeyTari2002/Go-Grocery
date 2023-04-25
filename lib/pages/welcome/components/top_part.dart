import 'package:flutter/cupertino.dart';

class TopPart extends StatelessWidget {
  const TopPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
        children: const [
        Text("Welcome to GROCERY",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
        )),
        Text("Explore Us  ",style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 28,
        )),
        ],
        )
      ],

    );

  }
}
