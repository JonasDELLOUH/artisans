import 'package:artisans/presentation/personal_data/personal_data_controller.dart';
import 'package:artisans/widgets/custom_icon.dart';
import 'package:artisans/widgets/custom_image_network.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:artisans/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/icons.dart';
import '../../widgets/text_field.dart';

class PersonalDataScreen extends GetView<PersonalDataController> {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
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
              Center(
              child: Stack(
                children: [
                  CustomImageNetwork(
                    imageUrl: "https://images.unsplash.com/photo-1575535468632-345892291673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80", width: 100, height: 100, borderRadius: const BorderRadius.all(Radius.circular(100)),),
                  const Positioned(
                    right: 0,
                      bottom: 0,
                      child: Icon(Icons.add_a_photo))
                ],
              ),
      ),
                const SizedBox(height: 50,),
                const CustomText(text: "Email"),
                const SizedBox(height: 5,),
                CustomTextFormField(
                  hintText: "jdellouh1@gmail.com",
                  controller: controller.emailController,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),),
                const SizedBox(
                  height: 15,
                ),
                CustomText(text: "name".tr),
                const SizedBox(height: 5,),
                CustomTextFormField(
                    controller: controller.nameController,
                    hintText: "Jonas DELLOUH",
                    borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomText(text: "phone".tr),
                const SizedBox(height: 5,),
                CustomTextFormField(
                  keyboardType: TextInputType.phone,
                    hintText: "+229 96133525",
                    controller: controller.phoneController,
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
      ),
    );
  }
}