import 'package:flutter/material.dart';

class CenterPart extends StatelessWidget {
  final TextEditingController? email;
  final TextEditingController? password;
  final Function()? onPressed;
  final Widget icon;
  final bool obscureText;

   const CenterPart({
     required this.obscureText,
     required this.email,
     required this.password,
    required this.onPressed,

     Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: email,
          //text bo to type deatils
          decoration: const InputDecoration(
            hintText: "Email address",
          ),
        ),
        TextFormField(
          obscureText: obscureText,
          controller: password,
          decoration: InputDecoration(
              hintText: "Password",
              suffixIcon: IconButton(
                  onPressed: onPressed, icon: icon)),
        ),
      ],
    );
  }
}
