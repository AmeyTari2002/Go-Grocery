import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CenterPart extends StatelessWidget {
  const CenterPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Image.asset("assets/images/Grocery_logo.png"),
    );
  }
}
      
      
      
      
      

