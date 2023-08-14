import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/presentation/add_post/add_post_controller.dart';
import 'package:artisans/widgets/custom_button.dart';
import 'package:artisans/widgets/custom_image_asset.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../widgets/custom_image_file.dart';
import '../../widgets/take_tof_empty.dart';
import '../../widgets/text_field.dart';

class AddPostScreen extends GetView<AddPostController> {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const BackButton(
          color: blueColor,
        ),
        title: Obx(() => CustomText(
              text:
                  controller.isPost.value ? "add_a_post".tr : "add_a_story".tr,
              fontSize: 14,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => CustomTextButton(
                          onPressed: () {
                            if (!controller.isPost.value) {
                              controller.isPost.value = true;
                            }
                          },
                          text: "Post",
                          borderRadius: 10,
                          fontSize: 14,
                          height: 35,
                          backgroundColor:
                              controller.isPost.value ? blueColor : greyColor,
                        ),
                      ),
                      Obx(() => CustomTextButton(
                            onPressed: () {
                              if (controller.isPost.value) {
                                controller.isPost.value = false;
                              }
                            },
                            text: "Story",
                            borderRadius: 10,
                            fontSize: 14,
                            height: 35,
                            backgroundColor: !controller.isPost.value
                                ? blueColor
                                : greyColor,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: "content".tr,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: blueColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    maxLines: null,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => CustomText(
                      text: controller.isPost.value ? "Image" : "Video",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: blueColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                      onTap: () {
                        controller.showPicker(Get.context);
                      },
                      child: Obx(() => ((controller.isPost.value &&
                                  controller.postImg.value == null) ||
                              (!controller.isPost.value &&
                                  controller.postVideo.value == null))
                          ? takeTofEmptyView(text: "take_salon_image1".tr)
                          : Center(
                              child: CustomPictureView(
                                file: controller.isPost.value
                                    ? controller.postImg.value!
                                    : controller.postImg.value!,
                                width: Get.width * 0.8,
                                height: 200,
                                isVideo: !controller.isPost.value,
                              ),
                            )))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: Get.height - 200),
                child: RoundedLoadingButton(
                  width: Get.width * 0.7,
                  height: 50,
                  controller: controller.btnController,
                  onPressed: () {},
                  color: blueColor,
                  borderRadius: 10,
                  child: CustomText(text: "add".tr, color: whiteColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
