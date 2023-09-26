import 'package:artisans/presentation/personal_data/personal_data_controller.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../core/colors/colors.dart';
import '../../core/functions/basics_functions.dart';
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
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Obx(() => Center(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: blueColor,
                    child: CustomText(
                      fontSize: 30,
                      text: (controller
                          .appServices.currentUser.value?.username
                          .substring(0, 1)
                          .toUpperCase()) ??
                          "",
                      color: whiteColor,
                    ),
                  ),
                )),
                  const SizedBox(height: 50,),
                  CustomText(text: "name".tr),
                  const SizedBox(height: 5,),
                  CustomTextFormField(
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return 'field_must_not_be_empty'.tr;
                        }
                        return null;
                      },
                      hintText: "name".tr,
                      controller: controller.nameController,
                      borderRadius: const BorderRadius.all(Radius.circular(15))
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(text: "Email"),
                  const SizedBox(height: 5,),
                  CustomTextFormField(
                    validator: (validator) {
                      if (validator!.isEmpty) {
                        return null;
                      } else if (!isEmailValid(validator)) {
                        return 'invalid_email'.tr;
                      }
                      return null;
                    },
                    hintText: "Email",
                    controller: controller.emailController,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomText(text: "phone".tr),
                  const SizedBox(height: 5,),
                  CustomTextFormField(
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return null;
                        } else if (!isPhoneNumberValid(validator)) {
                          return 'invalid_phone_number'.tr;
                        }
                        return null;
                      },
                    hintText: "phone".tr,
                    keyboardType: TextInputType.phone,
                      controller: controller.phoneController,
                      borderRadius: const BorderRadius.all(Radius.circular(15))
                  ),

                  const SizedBox(height: 30,),
                  RoundedLoadingButton(
                    width: Get.width * 0.7,
                    height: 50,
                    controller: controller.btnController,
                    onPressed: () {
                      if(controller.canUpdate()){
                        controller.updateProfile();
                      } else{
                        controller.btnController.stop();
                      }
                    },
                    color: blueColor,
                    borderRadius: 10,
                    child: CustomText(text: "update".tr, color: whiteColor),
                  )

      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}