import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/presentation/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/icons.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_field.dart';
import '../../widgets/text_widgets.dart';

class SignUpScreen extends GetWidget<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: blueColor,
          body: Stack(
            children: [
              Container(
                height: 200,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            child: ConstantIcons.backIcon(context, color: whiteColor),
                          onTap: (){

                          },
                        ),
                        Row(
                          children: [
                            customText(
                                text: "has_already_account".tr,
                                color: whiteColor,
                                fontSize: 12),
                            CustomTextButton(
                                text: "sign_in".tr,
                                onPressed: (){
                                  Get.toNamed(AppRoutes.signInRoute);
                                },
                                textColor: whiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                backgroundColor: goldenColor),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customText(
                        text: "Artisans",
                        color: whiteColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 150),
                child: Stack(
                  children: [
                    Container(
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: whiteColor.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)))),
                    Container(
                      height: height - 160,
                      padding: const EdgeInsets.all(20),
                      width: width,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            customText(
                                text: "start".tr,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            const SizedBox(
                              height: 10,
                            ),
                            customText(
                                text: "enter_detail".tr,
                                color: blackColor.withOpacity(0.4)),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                                controller: controller.emailController,
                                labelText: 'email_address'.tr, borderRadius: const BorderRadius.all(Radius.circular(15)),),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextFormField(
                                controller: controller.nameController,
                                labelText: 'your_name'.tr,
                                borderRadius: const BorderRadius.all(Radius.circular(15))
                               ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextFormField(
                                controller: controller.passwordController,
                                labelText: 'password'.tr,
                                suffixIcon: ConstantIcons.visibility(
                                    color: greyColor.withOpacity(0.6)),
                                borderRadius: const BorderRadius.all(Radius.circular(15))
                            ),
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
                              customText(text: "sign_up".tr, color: whiteColor),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Container(height: 1, color: greyColor.withOpacity(0.2))),
                                Expanded(
                                    flex: 2,
                                    child: Center(child: customText(text: "or_sign_with".tr, color: greyColor.withOpacity(0.5), fontWeight: FontWeight.w600))),
                                Expanded(child: Container(height: 1, color: greyColor.withOpacity(0.2)))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    height: 50,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: greyColor.withOpacity(0.1)),
                                      borderRadius: const BorderRadius.horizontal(
                                          left: Radius.circular(15), right: Radius.circular(15)),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/google.png',
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(width: 5,),
                                          customText(text:
                                          "Google",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    height: 50,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: greyColor.withOpacity(0.1)),
                                      borderRadius: const BorderRadius.horizontal(
                                          left: Radius.circular(15), right: Radius.circular(15)),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/facebook.png',
                                            height: 20,
                                            width: 20,
                                          ),

                                          customText(text:
                                          "Facebook",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
