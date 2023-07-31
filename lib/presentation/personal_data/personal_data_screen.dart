import 'package:artisans/presentation/personal_data/personal_data_controller.dart';
import 'package:artisans/widgets/custom_icon.dart';
import 'package:artisans/widgets/custom_image_network.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:artisans/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/icons.dart';
import '../../widgets/text_field.dart';

class PersonalDataScreen extends GetView<PersonalDataController> {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
              Center(
              child: Stack(
                children: [
                  CustomImageNetwork(
                    imageUrl: "https://images.unsplash.com/photo-1575535468632-345892291673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80", width: 100, height: 100, borderRadius: BorderRadius.all(Radius.circular(100)),),
                  const Positioned(
                    right: 0,
                      bottom: 0,
                      child: Icon(Icons.add_a_photo))
                ],
              ),
      ),
                const SizedBox(height: 50,),
                CustomText(text: "email".tr),
                CustomTextFormField(
                  hintText: "jdellouh1@gmail.com",
                  controller: controller.emailController,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                    controller: controller.nameController,
                    hintText: "Jonas DELLOUH",
                    borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                    controller: controller.lastPasswordController,
                    borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                    controller: controller.lastPasswordController,
                    borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
      ],
            ),
          ),
        ),
      ),
    );
  }
}