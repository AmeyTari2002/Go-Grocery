import 'package:flutter/material.dart';
import 'package:miniproject/pages/login/components/center_part.dart';
import 'package:miniproject/pages/login/components/end_part.dart';
import 'package:miniproject/pages/login/components/login_auth_provider.dart';
import 'package:miniproject/pages/login/components/top_part.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visibile = true;
  @override
  Widget build(BuildContext context) {
    LoginAuthProvider loginAuthProvider =
        Provider.of<LoginAuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4, //appbar lifted
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // top part
            TopPart(),
            //center part
            CenterPart(
              obscureText: visibile,
              email: email,
              password: password, onPressed: () {
                setState(() {
                  visibile=! visibile;
                });
            },
              icon:  Icon(
                 visibile? Icons.visibility_off: Icons.visibility,
              ),
            ),
            //end part
            EndPart(
              loading: loginAuthProvider.loading,
              onPressed: () {
                loginAuthProvider.loginPageValidation(
                    emailAddress: email, password: password, context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
