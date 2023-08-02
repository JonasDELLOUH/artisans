import 'package:artisans/presentation/create_salon/create_salon_controller.dart';
import 'package:artisans/presentation/create_salon/widgets/step_tile.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/colors/colors.dart';
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
              Obx(() =>
              controller.stepIndex.value == 1 ?
              infoStepWidget() : controller.stepIndex.value == 2
                  ? addressWidget()
                  : imageView()),
              const SizedBox(height: 50,),
              stepsNumbers(),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return Center(
                  child: CustomTextButton(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    borderRadius: 15,
                    onPressed: () {
                      if (controller.stepIndex.value == 1) {
                        controller.stepIndex.value = 2;
                      } else if (controller.stepIndex.value == 2) {
                        controller.stepIndex.value = 3;
                      } else {
                        controller.stepIndex.value = 1;
                      }
                    },
                    backgroundColor: blueColor,
                    text:
                    controller.stepIndex.value == 3 ? "pay".tr : "next".tr,
                  ),
                );
              }),
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
            text: "take_location".tr),
        const SizedBox(height: 50,),
        FutureBuilder(
          future: precacheImage(
              controller.locationController.image, Get.context!),
          builder: (context, snapshot) {
            print(snapshot.hasData);
            print(snapshot.hasError);
            print(snapshot.connectionState);

            if (snapshot.connectionState == ConnectionState.done) {
              return ClipRRect(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(30)),
                  child: Image(
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
                      image: controller.locationController.image));
            } else {
              return Container(
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(
                        color: blueColor, width: 3)),
                width: 300,
                height: 264,
                child: Center(
                    child: CustomText(text: "${"loading".tr}....")),
              );
            }
          },
        )
      ],
    );
  }

  Widget imageView() {
    return  Column(
      children: [
        CustomText(text: "take_salon_image".tr)
      ],
    );
  }

  Widget infoStepWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "choose_job".tr),
        const SizedBox(height: 5,),
        InkWell(
            onTap: () {
              DropDownState(
                DropDown(
                  bottomSheetTitle: CustomText(
                    text: "choose_job".tr, color: blueColor,),
                  submitButtonChild: const CustomText(text:
                  'Done',
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
            child: Obx(() =>
                CustomTextFormField(
                  enabled: false,
                  hintText: controller.itemSelected.value!.name,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ))
        ),
        const SizedBox(height: 10,),
        CustomText(text: "salon_name".tr),
        const SizedBox(height: 5,),
        CustomTextFormField(
          controller: controller.salonNameController,
          hintText: "salon_name".tr,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        const SizedBox(height: 10,),
        CustomText(text: "salon_mail".tr),
        const SizedBox(height: 5,),
        CustomTextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          hintText: "salon_mail".tr,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        const SizedBox(height: 10,),
        CustomText(text: "salon_phone".tr),
        const SizedBox(height: 5,),
        CustomTextFormField(
          controller: controller.telController,
          keyboardType: TextInputType.phone,
          hintText: "salon_phone".tr,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
      ],
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
              isOn: controller.stepIndex.value > 0
                  ? true
                  : false);
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
                controller.stepIndex.value = 2;
              },
              isOn: controller.stepIndex.value > 1
                  ? true
                  : false);
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
              isOn: controller.stepIndex.value > 2
                  ? true
                  : false);
        }),
      ],
    );
  }
}
