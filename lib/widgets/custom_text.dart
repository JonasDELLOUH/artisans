import 'package:artisans/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double letterSpacing;
  final Color? color;
  final int? maxLength;

  const CustomText(
      {Key? key,
      required this.text,
      this.textAlign,
      this.textDirection,
      this.softWrap,
      this.overflow,
      this.maxLines,
      this.fontSize = 16.0,
      this.fontWeight = FontWeight.w400,
      this.fontStyle = FontStyle.normal,
      this.letterSpacing = 0.0,
      this.color = Colors.black,
      this.maxLength})
      : super(key: key);

  String truncateText() {
    if (text.length <= maxLength!) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // maxLength != null ? truncateText() : text,
      style: GoogleFonts.robotoSlab(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          overflow: TextOverflow.ellipsis,
          letterSpacing: letterSpacing,
          color: color,
        ),
      ),
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap ?? true,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
