import 'package:flutter/material.dart';
import 'package:miniproject/pages/signup/components/signup_auth_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_button.dart';
import '../login/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController fullName = TextEditingController(); //to save the text
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  bool visibility =
      true; // initiale value must be false of password view button
  @override
  Widget build(BuildContext context) {
    // signup k button ko click karna p print hona chahiye
    //so signupauthprovider object banaya h

    SignupAuthProvider signupAuthProvider =
        Provider.of<SignupAuthProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                TextFormField(
                  controller: fullName,
                  //text bo to type deatils
                  decoration: InputDecoration(
                    hintText: "Full name",
                  ),
                ),
                TextFormField(
                  controller: emailAddress,
                  //text bo to type deatils
                  decoration: InputDecoration(
                    hintText: "Email address",
                  ),
                ),
                TextFormField(
                  controller: password,
                  obscureText: visibility, //hide password
                  //text bo to type deatils
                  decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visibility = !visibility;
                            });
                          },
                          icon: Icon(visibility
                              ? Icons.visibility_off
                              : Icons.visibility))),
                ),
              ],
            ),
            Column(
              children: [
                signupAuthProvider.loading == false
                    ? MyButton(
                        onPressed: () {
                          //function o acces kr raha h
                          signupAuthProvider.signupValidation(
                              fullName: fullName,
                              context: context,
                              emailAddress: emailAddress,
                              password: password);
                        },
                        text: "SIGN UP",
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?\t\t"),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>  LoginPage(),
                          ),
                        );
                      },
                      child: Text("LOGIN"),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
