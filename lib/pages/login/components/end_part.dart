import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/my_button.dart';
import '../../signup/signup_page.dart';

class EndPart extends StatelessWidget {
  final void Function()? onPressed;
  bool  loading;
  EndPart({Key? key,
    required this.onPressed,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loading==true?CircularProgressIndicator():
        MyButton(onPressed: onPressed, text: "Login"),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an Acoount?\t\t",
              style: TextStyle(fontSize: 15),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                );
              },
              child: Text(
                "Sign In",
                style: TextStyle(fontSize: 17),
              ),
            )
          ],
        ),
      ],
    );
  }
}
