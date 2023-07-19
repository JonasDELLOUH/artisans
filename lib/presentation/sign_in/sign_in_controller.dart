import 'package:artisans/core/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/constants/constants.dart';
import '../../data/api/api_client.dart';
import '../../data/functions/functions.dart';

class SignInController extends GetxController{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();


  signIn() async {
    final apiClient = ApiClient();
    Map<String, dynamic> map = {
      "username": usernameController.value.text,
      "password": passwordController.value.text
    };

    var response = await apiClient.postFromApi(signInUrl, map);
    btnController.stop();

    if (response["result"] != null) {
      if (response["result"].containsKey("errors")) {
        appSnackBar("error", "authentication_failed".tr,
            response["result"]["errors"][0]);
      } else {
        response["result"]["accessToken"];
        Get.toNamed(AppRoutes.menuRoute);
      }
    } else {
      appSnackBar("error", "authentication_failed".tr, response["error"]);
    }
  }
}