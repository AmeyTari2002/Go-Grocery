import 'package:flutter/material.dart';
import 'package:miniproject/pages/welcome/components/top_part.dart';

import 'components/End_Part.dart';
import 'components/center_part.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(       //basically vo status bar k andar n aye
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                //top part
                TopPart(),
                //center part
                CenterPart(),
                // End part
                EndPart(),

              ],
            ),
          )),

    );
  }
}
