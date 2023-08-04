import 'package:artisans/core/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final EdgeInsetsGeometry contentPadding;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final TextStyle? labelStyle;
  final BorderRadius borderRadius;
  final String? Function(String?)? validator;
  final bool? enabled;
  int? maxLines;

   CustomTextFormField(
      {Key? key,
        this.controller,
        this.keyboardType,
        this.hintText,
        this.hintStyle,
        this.textStyle,
        this.suffixIcon,
        this.prefixIcon,
        this.obscureText = false,
        this.contentPadding =
        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        this.border,
        this.onChanged,
        this.labelText,
        this.labelStyle,
        this.maxLines = 1,
        this.borderRadius = BorderRadius.zero,
        this.validator, this.focusedBorder, this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      enabled: enabled,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: textStyle ??
          const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400),
      onChanged: onChanged,
      cursorColor: blueColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding,
        border: border ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
              ),
              borderRadius: borderRadius,
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: redColor
          ),
          borderRadius: borderRadius,
        ),
        focusedBorder: focusedBorder ?? OutlineInputBorder(
          borderSide: const BorderSide(
            color: blueColor,
            width: 1,
          ),
          borderRadius: borderRadius,
        ),
        labelText: labelText,
        labelStyle: labelStyle ?? const TextStyle(
          color: blueColor
        ),
      ),
    );
  }
}