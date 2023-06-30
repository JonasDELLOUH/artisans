import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

Widget customTextField(
    {required TextEditingController controller,
    String? labelText,
    String? hintText,
    bool obscureText = false,
      Key? kKey,
      TextInputType? textInputType = TextInputType.text,
      void Function(String)? onChanged,
void Function(String?)? onSaved,
String? Function(String?)? validator,
      Widget? prefixIcon,
      Widget? suffixIcon,
      String? errorText
    }) {
  return TextFormField(
    controller: controller,
    cursorColor: blueColor,
    style: textStyle(color: blackColor, fontSize: 12),
    key: kKey,
    keyboardType: textInputType,
    onSaved: onSaved,
    onChanged: onChanged,
    validator: validator,
    obscureText: obscureText,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        labelText: labelText,
        labelStyle: textStyle(color: blueColor, fontSize: 14),
        hintText: hintText,
        hintStyle: textStyle(color: blueColor),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(
            color:  greyColor.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          //gapPadding: 16,
          borderSide: BorderSide(
            color:  greyColor.withOpacity(0.2),
          ),
        ),
        errorStyle: textStyle(),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: redColor,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          //gapPaddings: 16,
          borderSide: BorderSide(
            color: greyColor,
          ),
        ),
        errorText: errorText),
  );
}
