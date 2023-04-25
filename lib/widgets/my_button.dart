
import 'package:flutter/material.dart';

  class MyButton extends StatefulWidget {
  final void Function()? onPressed;
  final String text;
   const MyButton({Key? key,
  required this.onPressed,
  required  this.text,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return  MaterialButton(onPressed: widget.onPressed,
      height: 50,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(04)
      ),
      padding: EdgeInsets.all(0),
      child: Ink(
        decoration:  BoxDecoration(
          gradient: const LinearGradient(
              colors:[
                Color(0xff027f47),
                Color(0xff01a95c),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
          ),
          borderRadius: BorderRadius.circular(05),
        ),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child:  Text(
            widget.text,
            style: TextStyle(
              fontSize: 23,color: Colors.white)),
        ),
      ),
    );
  }
}
