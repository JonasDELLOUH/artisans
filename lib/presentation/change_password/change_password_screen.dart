import 'package:artisans/presentation/change_password/change_password_controller.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/colors/colors.dart';
import '../../widgets/text_field.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: CustomText(text: "change_password".tr,),
        leading: const BackButton(
          color: blueColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "last_password".tr),
              const SizedBox(height: 5,),
              CustomTextFormField(
                hintText: "*************",
                controller: controller.lastPasswordController,
                borderRadius: const BorderRadius.all(Radius.circular(15)),),
              const SizedBox(
                height: 15,
              ),
              CustomText(text: "new_password".tr),
              const SizedBox(height: 5,),
              CustomTextFormField(
                  controller: controller.newPasswordController,
                  hintText: "*************",
                  borderRadius: const BorderRadius.all(Radius.circular(15))
              ),
              const SizedBox(height: 30,),
              RoundedLoadingButton(
                width: Get.width * 0.7,
                height: 50,
                controller: controller.btnController,
                onPressed: () {},
                color: blueColor,
                borderRadius: 10,
                child: CustomText(text: "update".tr, color: whiteColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
