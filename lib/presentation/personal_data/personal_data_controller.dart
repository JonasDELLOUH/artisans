import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../data/services/app_services.dart';
import '../../data/data_models/update_profile_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class PersonalDataController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final formKey = GlobalKey<FormState>();
  RxBool updatingData = false.obs;
  final appServices = Get.find<AppServices>();


  String initialName = "";
  String initialEmail = "";
  String initialNumber = "";


  @override
  void onInit() {
    super.onInit();
    loadData();
  }
  
  loadData(){
    initialName = appServices.currentUser.value?.username ?? "";
    initialEmail = appServices.currentUser.value?.email ?? "";
    initialNumber = appServices.currentUser.value?.tel ?? "";
    nameController.text = initialName;
    emailController.text = initialEmail;
    phoneController.text = initialNumber;
  }

  bool canUpdate() {
    if (formKey.currentState?.validate() ?? false) {
      return dateIsChanged();
    }
    return false;
  }

  bool dateIsChanged() {
    bool dateIsChanged = false;
    dateIsChanged = !(
        initialName == nameController.text &&
            initialEmail == emailController.text &&
            initialNumber == phoneController.text
    );
    if (!dateIsChanged) {
      appSnackBar("error", "not_changed_info".tr, "");
    }
    return dateIsChanged;
  }

  updateProfile() async {
    try {
      updatingData.value = true;
      UpdateProfileData updateProfileData = (await ApiServices.updateUserProfile(
          email: emailController.value.text,
          phoneNumber: phoneController.text, username: nameController.text));
      await appServices.setCurrentUser(updateProfileData.userModel!, appServices.token.value);
      updatingData.value = false;
      Get.back();
      appSnackBar("success", "profile_updated".tr, "");
      btnController.stop();
    } catch (e) {
      btnController.stop();
      debugPrint("e.response?.data : $e");
      updatingData.value = false;
      if (e is DioException) {
        appSnackBar("error", "failed".tr, "${e.response?.data["message"] ?? e.response?.data}");
      }
    }
  }
}
