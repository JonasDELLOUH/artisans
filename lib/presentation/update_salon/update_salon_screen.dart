import 'package:artisans/presentation/update_salon/update_salon_controller.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/colors/colors.dart';
import '../../core/functions/basics_functions.dart';
import '../../widgets/custom_picture_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/take_tof_empty.dart';
import '../../widgets/text_field.dart';

class UpdateSalonScreen extends GetWidget<UpdateSalonController> {
  const UpdateSalonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Material(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.only(bottom: 10),
          child: RoundedLoadingButton(
            width: Get.width * 0.7,
            height: 50,
            controller: controller.btnController,
            onPressed: () {},
            color: blueColor,
            borderRadius: 10,
            child: CustomText(text: "update".tr, color: whiteColor),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: CustomText(
          text: "my_salon".tr,
        ),
        leading: const BackButton(
          color: blueColor,
        ),
      ),
      body:  Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              infoStepWidget(),
              const SizedBox(
                height: 20,
              ),
              imageView(),
              const SizedBox(
                height: 20,
              ),
              addressWidget(),

              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addressWidget() {
    return Column(
      children: [
        CustomText(
          text: "take_location".tr,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 50,
        ),
        Obx(() => FutureBuilder(
          future: precacheImage(
              controller.locationController.value.image, Get.context!),
          builder: (context, snapshot) {
            debugPrint("${snapshot.hasData}");
            debugPrint("${snapshot.hasError}");
            debugPrint("${snapshot.connectionState}");

            if (snapshot.connectionState == ConnectionState.done) {
              return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Obx(() => Image(
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30)),
                                border: Border.all(
                                    color: Colors.red, width: 3)),
                            width: 300,
                            height: 264,
                            child: Center(
                                child: CustomText(
                                    text: "${"loading_error".tr}....")),
                          ),
                      image: controller.locationController.value.image)));
            } else {
              return Container(
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: blueColor, width: 3)),
                width: 300,
                height: 264,
                child:
                Center(child: CustomText(text: "${"loading".tr}....")),
              );
            }
          },
        ))
      ],
    );
  }

  Widget imageView() {
    return Column(
      children: [
        CustomText(text: "take_salon_image".tr),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              controller.showPicker(Get.context);
            },
            child: Obx(() => controller.salonImage.value == null
                ? takeTofEmptyView(text: "take_salon_image1".tr)
                : Center(
              child: CustomPictureView(
                file: controller.salonImage.value!,
                width: Get.width * 0.8,
                height: 200,
              ),
            )))
      ],
    );
  }

  Widget infoStepWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "choose_job".tr),
        const SizedBox(
          height: 5,
        ),
        InkWell(
            onTap: () {
              DropDownState(
                DropDown(
                  bottomSheetTitle: CustomText(
                    text: "choose_job".tr,
                    color: blueColor,
                  ),
                  submitButtonChild: const CustomText(
                    text: 'Done',
                    fontWeight: FontWeight.bold,
                  ),
                  searchHintText: "search".tr,
                  data: controller.selectedListItems.value,
                  selectedItems: (List<dynamic> selectedList) {
                    List<String> list = [];
                    for (var item in selectedList) {
                      if (item is SelectedListItem) {
                        controller.itemSelected.value = item;
                      }
                    }
                  },
                  enableMultipleSelection: false,
                ),
              ).showModal(Get.context);
            },
            child: Obx(() => CustomTextFormField(
              enabled: false,
              hintText: controller.itemSelected.value?.name,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ))),
        const SizedBox(
          height: 10,
        ),
        CustomText(text: "salon_name".tr),
        const SizedBox(
          height: 5,
        ),
        CustomTextFormField(
          validator: (validator) {
            if (validator!.isEmpty) {
              return 'field_must_not_be_empty'.tr;
            }
            return null;
          },
          controller: controller.salonNameController,
          hintText: "salon_name".tr,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(text: "salon_mail".tr),
        const SizedBox(
          height: 5,
        ),
        CustomTextFormField(
          validator: (validator) {
            if (validator!.isEmpty) {
              return null;
            } else if (!isEmailValid(validator)) {
              return 'invalid_email'.tr;
            }
            return null;
          },
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          hintText: "salon_mail".tr,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(text: "salon_phone".tr),
        const SizedBox(
          height: 5,
        ),
        CustomTextFormField(
          validator: (validator) {
            if (validator!.isEmpty) {
              return null;
            } else if (!isPhoneNumberValid(validator)) {
              return 'invalid_phone_number'.tr;
            }
            return null;
          },
          controller: controller.telController,
          keyboardType: TextInputType.phone,
          hintText: "salon_phone".tr,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(text: "salon_desc".tr),
        const SizedBox(
          height: 5,
        ),
        CustomTextFormField(
          validator: (validator) {
            if (validator!.isEmpty) {
              return 'field_must_not_be_empty'.tr;
            }
            return null;
          },
          controller: controller.descController,
          keyboardType: TextInputType.text,
          hintText: "salon_desc".tr,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          maxLines: 5,
        ),
      ],
    );
  }
}
