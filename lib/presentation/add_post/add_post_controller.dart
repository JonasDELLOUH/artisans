import 'dart:io';
import 'package:artisans/data/data_models/create_post_data.dart';
import 'package:artisans/data/data_models/create_story_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../core/colors/colors.dart';
import '../../core/services/app_services.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';
import '../../widgets/custom_text.dart';

class AddPostController extends GetxController {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  TextEditingController contentController = TextEditingController();
  RxBool isPost = true.obs;
  RxBool creatingPostOrStory = false.obs;
  final formKey = GlobalKey<FormState>();
  final appServices = Get.find<AppServices>();

  Rxn<File> postImg = Rxn<File>();
  Rxn<File> storyVideo = Rxn<File>();

  Future getImage() async {
    ImagesPicker.pick(
      language: Language.English,
    );
  }

  void imgFromCamera() async {
    final images = await ImagesPicker.openCamera(
      pickType: isPost.value ? PickType.image : PickType.video,
    );

    if (images != null && images.isNotEmpty) {
      final selectedImage = images[0];
      if (isPost.value) {
        postImg.value = File(selectedImage.path);
      } else {
        storyVideo.value = File(selectedImage.path);
      }
    }
  }

  imgFromGallery() async {
    final images = await ImagesPicker.pick(
      count: 1,
      pickType: isPost.value ? PickType.image : PickType.video,
    );

    if (images != null && images.isNotEmpty) {
      final selectedImage = images[0];
      if (isPost.value) {
        postImg.value = File(selectedImage.path);
      } else {
        storyVideo.value = File(selectedImage.path);
      }
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                      color: blueColor,
                    ),
                    title: const CustomText(
                      text: "Galery",
                    ),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera, color: blueColor),
                  title: const CustomText(text: "Camera"),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  addPostOrStorySalon() async {
    try {
      creatingPostOrStory.value = true;
      if (isPost.value) {
        CreatePostData createPostData = (await ApiServices.createPost(
            salonId: appServices.currentSalon.value?.salonId ?? "",
            content: contentController.value.text,
            image: postImg.value));
      } else {
        CreateStoryData createStoryData = (await ApiServices.createStory(
            salonId: appServices.currentSalon.value?.salonId ?? "",
            content: contentController.value.text,
            video: storyVideo.value));
      }

      creatingPostOrStory.value = false;
      Get.back();
      // appSnackBar("success", "salon_created".tr, "");
      btnController.stop();
    } catch (e) {
      btnController.stop();
      print("e.response?.data : $e");
      creatingPostOrStory.value = false;
      if (e is DioException) {
        appSnackBar("error", "failed".tr, "${e.response?.data}");
      }
    }
  }
}
