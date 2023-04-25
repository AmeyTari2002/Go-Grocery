import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home/home_page.dart';

class SignupAuthProvider with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(SignupAuthProvider.pattern.toString());
  UserCredential? userCredential;

  bool loading = false;

  void signupValidation(
      { // this is  function which is use to describe necessary condition
        required TextEditingController? fullName,
        required TextEditingController? emailAddress,
        required TextEditingController? password,
        required BuildContext context
      }) async {
    //An async keyword would try to help you turn your function into asynchronous most of the time by enforcing the return type of your function to Future.
    if (fullName!
        .text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Full name is empty"),
        ),
      );
      return;
    } else if (emailAddress!
        .text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Emailaddress is empty"),
        ),
      );
      return;
    } else if (password!
        .text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password is empty"),
        ),
      );
      return;
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password must be 8"),
        ),
      );
      return;
    }
    else {
      try {
        loading = true;
        notifyListeners();
        userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text,

        );
        loading = true;
        notifyListeners();
        FirebaseFirestore.instance
            .collection("user")
            .doc(userCredential!.user!.uid)
            .set(
          {
            "fullname": fullName.text,
            "emailAddress": emailAddress.text,
            "password": password.text,
            "userUid": userCredential!.user!.uid,
          },
        ).then((value) {
          loading = false;
          notifyListeners();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) =>  HomePage(),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("weak-password"),
              )
          );
        }else if (!regExp.hasMatch(emailAddress.text.trim())) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid email address"),
            ),
          );
          return;
        }
        else if (e.code == 'email-already-use') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("email-already-use"),
              )
          );
        }
      }
    }
  }
}