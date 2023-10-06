import 'package:artisans/presentation/create_salon/create_salon_controller.dart';
import 'package:artisans/presentation/create_salon/widgets/step_tile.dart';
import 'package:artisans/widgets/custom_picture_view.dart';
import 'package:artisans/widgets/take_tof_empty.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../core/colors/colors.dart';
import '../../core/functions/basics_functions.dart';
import '../../data/functions/functions.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/text_field.dart';

class CreateSalonScreen extends GetView<CreateSalonController> {
  const CreateSalonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: CustomText(
          text: "create_salon".tr,
        ),
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
              Obx(() => controller.stepIndex.value == 1
                  ? infoStepWidget()
                  : controller.stepIndex.value == 2
                      ? addressWidget()
                      : imageView()),
              const SizedBox(
                height: 50,
              ),
              stepsNumbers(),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Obx(() => controller.stepIndex.value == 3
                    ? RoundedLoadingButton(
                        width: Get.width * 0.82,
                        height: 50,
                        controller: controller.btnController,
                        onPressed: () {
                          if (controller.step3IsOk()) {
                            controller.createSalon();
                          } else {
                            appSnackBar("error", "take_salon_image".tr, "");
                            controller.btnController.stop();
                          }
                        },
                        color: blueColor,
                        borderRadius: 10,
                        child: CustomText(text: "create".tr, color: whiteColor),
                      )
                    : CustomTextButton(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        borderRadius: 15,
                        onPressed: () {
                          if (controller.stepIndex.value == 1 &&
                              (controller.step1IsOk() ?? false)) {
                            controller.stepIndex.value = 2;
                          } else if (controller.stepIndex.value == 2) {
                            controller.stepIndex.value = 3;
                          }
                        },
                        backgroundColor: blueColor,
                        text: "next".tr,
                      )),
              ),
              const SizedBox(
                height: 20,
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
                print(snapshot.hasData);
                print(snapshot.hasError);
                print(snapshot.connectionState);

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
          height: 50,
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
    return Form(
      key: controller.formKey,
      child: Column(
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
                validator: (validator) {
                  if (controller.itemSelected.value?.name.isEmpty ?? true) {
                    return 'field_must_not_be_empty'.tr;
                  }
                  return null;
                },
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
          CustomText(text: "salon_whatsapp_number".tr),
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
            controller: controller.whatsappNumberController,
            keyboardType: TextInputType.phone,
            hintText: "salon_whatsapp_number".tr,
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
      ),
    );
  }

  Widget stepsNumbers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return stepTile(
              stepNumber: "1",
              onTap: () {
                controller.stepIndex.value = 1;
              },
              isOn: controller.stepIndex.value > 0 ? true : false);
        }),
        Obx(() {
          return betweenStep(
              context: Get.context!,
              color: controller.stepIndex.value > 1
                  ? blueColor
                  : greyColor.withOpacity(0.4));
        }),
        Obx(() {
          return stepTile(
              stepNumber: "2",
              onTap: () {
                if (controller.step1IsOk() ?? false) {
                  controller.stepIndex.value = 2;
                }
              },
              isOn: controller.stepIndex.value > 1 ? true : false);
        }),
        Obx(() {
          return betweenStep(
              context: Get.context!,
              color: controller.stepIndex.value > 2
                  ? blueColor
                  : greyColor.withOpacity(0.4));
        }),
        Obx(() {
          return stepTile(
              stepNumber: "3",
              onTap: () {
                controller.stepIndex.value = 3;
              },
              isOn: controller.stepIndex.value > 2 ? true : false);
        }),
      ],
    );
  }
}
