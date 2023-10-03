import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../core/routes/app_routes.dart';
import '../../data/services/app_services.dart';
import '../../data/data_models/user_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController(text: "jdellouh2@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "Jonas1007");
  TextEditingController nameController = TextEditingController(text: "JonasDELLOUH2");
  TextEditingController phoneController = TextEditingController(text: "96133502");
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
          email: emailController.value.text,
          phoneNumber: phoneController.value.text));
      btnController.stop();
      appServices.setCurrentUser(userData.userModel!, userData.token);
      await appServices.getUserSalon();
      Get.offAllNamed(AppRoutes.menuRoute);
    } catch (e) {
      debugPrint("$e");
      if (e is DioException) {
        appSnackBar("error", "Enrégistrement échouée", "${e.response?.data}");
      }
      btnController.stop();
    }
  }
}
