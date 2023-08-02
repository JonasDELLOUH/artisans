import 'package:artisans/core/colors/colors.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_text.dart';

Widget stepTile({required String stepNumber,void Function()? onTap, bool isOn = false}){
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          color: isOn ? blueColor
          : greyColor.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(35))
      ),
      child: Center(
        child: CustomText(text: stepNumber, color: isOn ? whiteColor : blackColor,),
      ),
    ),
  );
}

Widget betweenStep({required BuildContext context, required Color color}){
  return Container(
    height: 3.3,
    width: MediaQuery.of(context).size.width * 0.1,
    color: color,
  );
}