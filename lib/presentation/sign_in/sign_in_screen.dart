import 'package:artisans/core/constants/icons.dart';
import 'package:artisans/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: blueColor,
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Stack(
            children: [
              Row(
                children: [
                  ConstantIcons.backIcon(context, color: whiteColor),
                  myText(text: "Don't have an account?")
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

}
