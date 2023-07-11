import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/constants/icons.dart';
import 'package:artisans/core/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({Key? key, required this.controller, this.enabled}) : super(key: key);
  final TextEditingController controller;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration:  BoxDecoration(
        color: greyColor.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: CustomTextFormField(
        enabled: enabled,
        controller: controller,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        suffixIcon: Icon(Icons.work, color: greyColor.withOpacity(0.5), size: 30,),
        prefixIcon: Icon(Icons.search_rounded, color: greyColor.withOpacity(0.5), size: 30,),
        hintText: "search".tr,
        hintStyle: GoogleFonts.robotoSlab(
          textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: greyColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
