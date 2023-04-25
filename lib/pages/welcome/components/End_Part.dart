import 'package:flutter/material.dart';
import 'package:miniproject/pages/login/login_page.dart';
import 'package:miniproject/pages/signup/signup_page.dart';
import 'package:miniproject/widgets/my_button.dart';

import '../../routes/routing_page.dart';

class EndPart extends StatelessWidget {
  const EndPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onPressed: () {
            //media query
            RoutingPage.goTonext(
                context: context,
                navigateTo: const LoginPage(),);
            /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  LoginPage()));*/
          },
          text: "LOG IN",
        ),
        const SizedBox(height: 20,),
        GestureDetector(
          onTap: () {
            RoutingPage.goTonext(
              context: context,
              navigateTo: SignupPage(),
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupPage()),*/
            );
            print("Clicked");
          },
          child: const Text("Sign In", style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),),
        )


      ],
    );
  }
}
