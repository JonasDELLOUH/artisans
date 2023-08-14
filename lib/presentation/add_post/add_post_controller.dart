import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/colors/colors.dart';
import '../../widgets/custom_text.dart';

class AddPostController extends GetxController {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  RxBool isPost = true.obs;

  Rxn<File> postImg = Rxn<File>();
  Rxn<File> postVideo = Rxn<File>();

  Future getImage() async {
    ImagesPicker.pick(
      language: Language.English,
    );
  }

  void imgFromCamera() async {
    final images = await ImagesPicker.pick(
      count: 1,
      pickType: isPost.value ? PickType.image : PickType.video,
    );

    if (images != null && images.isNotEmpty) {
      final selectedImage = images[0];
      if(isPost.value){
        postImg.value = File(selectedImage.path);
      } else{
        postVideo.value = File(selectedImage.path);
      }
    }
  }

  imgFromGallery() async {
    final ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    dynamic files = [];
    files.add(File(image!.path));
    postImg.value = File(image.path);
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
}
