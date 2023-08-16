import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/constants/constants.dart';
import '../../core/functions/app_functions.dart';
import '../../core/models/user_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/app_services.dart';
import '../../data/api/api_client.dart';
import '../../data/data_models/user_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  RxBool passwordIsVisible = false.obs;
  final appServices = Get.find<AppServices>();
  final formKey = GlobalKey<FormState>();

  @override
  onInit() {
    Get.lazyPut(() => AppServices());
    super.onInit();
  }

  signUp() async {
    try {
      UserData userData = (await ApiServices.registerUser(
          username: nameController.value.text,
          password: passwordController.value.text,
          name: '',
          email: emailController.value.text,
          phoneNumber: phoneController.value.text));
      appServices.setCurrentUser(userData.userModel!, userData.token);
      btnController.stop();
      Get.offAllNamed(AppRoutes.menuRoute);
    } catch (e) {
      print(e);
      if (e is DioException) {
        appSnackBar("error", "Connection échouée", "${e.response?.data}");
      }
      btnController.stop();
    }
  }
}
