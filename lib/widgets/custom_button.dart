import 'package:artisans/core/colors/colors.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;
  final Color? backgroundColor;
  Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double elevation;
  final BorderSide? borderSide;
  final ButtonStyle? style;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double fontSize;
  double height;

  CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.height = 46,
    this.textStyle = const TextStyle(),
    this.backgroundColor = blueColor,
    this.padding,
    this.borderRadius = 10,
    this.elevation = 0.0,
    this.borderSide,
    this.style,
    this.textAlign = TextAlign.center,
    this.fontWeight = FontWeight.w400,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: style ?? TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderSide ?? BorderSide.none,
          ),
          elevation: elevation,
        ),
        child: CustomText(
          text: text,
          color: textColor!,
          fontWeight: fontWeight,
          fontSize: fontSize,
          textAlign: textAlign,
        ),
      ),
    );
  }
}