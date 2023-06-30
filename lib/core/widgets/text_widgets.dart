import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
Widget CustomText(
    {required String text,
    Color color = blackColor,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    bool isUnderline = false,
    bool subs = false,
    int subsStart = 0,
    int subsEnd = 20}) {
  return Text(
    subs
        ? text.length > subsEnd
            ? "${text.substring(subsStart, subsEnd)}..."
            : text
        : text,
    style: GoogleFonts.robotoSlab(
      textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration:
              isUnderline ? TextDecoration.underline : TextDecoration.none),
    ),
    // maxLines: 4,
    textAlign: textAlign,
    softWrap: true,
  );
}

TextStyle textStyle(
    {Color color = blackColor,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.start,
    bool isUnderline = false}) {
  return GoogleFonts.robotoSlab(
    textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none),
  );
}
