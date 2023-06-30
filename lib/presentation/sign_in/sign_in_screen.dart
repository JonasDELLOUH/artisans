import 'package:artisans/core/constants/icons.dart';
import 'package:artisans/core/widgets/custom_button.dart';
import 'package:artisans/core/widgets/text_widgets.dart';
import 'package:artisans/presentation/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/colors/colors.dart';
import '../../core/utils/gradient.dart';
import '../../core/widgets/text_field.dart';

class SignInScreen extends GetWidget<SignInController> {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: blueColor,
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstantIcons.backIcon(context, color: whiteColor),
                  Row(
                    children: [
                      CustomText(
                          text: "have_not_account".tr,
                          color: whiteColor,
                          fontSize: 12),
                      CustomTextButton(
                          text: "start".tr,
                          textColor: whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          backgroundColor: goldenColor),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                  text: "Artisans",
                  color: whiteColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 40,
              ),
              Flexible(
                child: Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: whiteColor.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)))),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: width,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                              text: "welcome_back".tr,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomText(
                              text: "enter_detail".tr,
                              color: blackColor.withOpacity(0.4)),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextField(
                              controller: controller.emailController,
                              labelText: 'email_address'.tr),
                          const SizedBox(
                            height: 15,
                          ),
                          customTextField(
                              controller: controller.emailController,
                              labelText: 'password'.tr,
                              suffixIcon: ConstantIcons.visibility(
                                  color: greyColor.withOpacity(0.6))),
                          const SizedBox(
                            height: 20,
                          ),
                          RoundedLoadingButton(
                            width: width * 0.82,
                            height: 50,
                            controller: controller.btnController,
                            onPressed: () {},
                            color: blueColor,
                            borderRadius: 10,
                            child:
                                CustomText(text: "sign_in".tr, color: whiteColor),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: (){},
                              child: CustomText(text: "forgot_password".tr, color: greyColor, fontWeight: FontWeight.w700)),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Container(height: 1, color: greyColor.withOpacity(0.2))),
                        Expanded(
                          flex: 2,
                            child: Center(child: CustomText(text: "or_sign_with".tr, color: greyColor.withOpacity(0.5), fontWeight: FontWeight.w600))),
                              Expanded(child: Container(height: 1, color: greyColor.withOpacity(0.2)))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }


}
