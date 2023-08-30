import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
customShowDialog({required BuildContext context, required String dialogTitle, String dialogDesc = "", void Function()? onOkay}){
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title:  CustomText(text: dialogTitle, fontWeight: FontWeight.bold,),
      content: CustomText(text: dialogDesc, fontSize: 14, ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Get.back(),
          child: CustomText(text: 'cancel'.tr, fontSize: 14),
        ),
        TextButton(
          onPressed: onOkay,
          child: CustomText(text: 'ok'.tr, fontSize: 14, color: redColor,),
        ),
      ],
    ),
  );
}