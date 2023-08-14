import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

Widget takeTofEmptyView({required String text, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      color: blueColor,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 200,
          color: blueColor.withOpacity(0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add,
                  color: blueColor,
                  size: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: text,
                  color: blueColor,
                  fontSize: 14,
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
