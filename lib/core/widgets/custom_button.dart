import 'package:artisans/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

Widget CustomTextButton({double height = 50, required String text,
  Color textColor = blackColor,
  Color backgroundColor = blueColor,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.normal,
void Function()? onPressed

}) {
  return Container(
    padding: EdgeInsets.all(5),
    margin: EdgeInsets.all(5),
    height: height,
    decoration: BoxDecoration(
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
      ),
      onPressed: onPressed,
      child: customText(text: text,fontWeight: fontWeight, fontSize: fontSize, color: textColor ),
    ),
  );
}
