import 'package:artisans/data/data_models/change_password_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class ChangePasswordController extends GetxController {
  TextEditingController lastPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  RxBool changingPassword = false.obs;
  final formKey = GlobalKey<FormState>();

  changePassword() async {
    try {
      changingPassword.value = true;
      ChangePasswordData changePasswordData = (await ApiServices.changePassword(
          currentPassword: lastPasswordController.text,
          newPassword: newPasswordController.text));
      changingPassword.value = false;
      Get.back();
      appSnackBar("success", "password_changed".tr, "");
      btnController.stop();
    } catch (e) {
      btnController.stop();
      debugPrint("e.response?.data : $e");
      changingPassword.value = false;
      if (e is DioException) {
        appSnackBar("error", "failed".tr, "${e.response?.data["message"] ?? e.response?.data}");
      }
    }
  }
}
