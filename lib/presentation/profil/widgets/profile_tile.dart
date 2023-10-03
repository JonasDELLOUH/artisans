import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget profileTile({required IconData iconData, required String tileName, String tileSubName = "", Color color = blueColor, void Function()? onTap}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(7))),
            child: Center(
              child: Icon(
                iconData,
                color: color,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: tileName,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                !tileSubName.isEmptyOrNull ? CustomText(
                  text: tileSubName,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: blackColor.withOpacity(0.5),
                ) : Container(),
              ],
            ),
          ),
          Icon(
            Icons.arrow_circle_right_outlined,
            color: color.withOpacity(0.5),
          )
        ],
      ),
    ),
  );
}
