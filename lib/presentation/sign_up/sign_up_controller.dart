import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/constants/constants.dart';
import '../../core/functions/app_functions.dart';
import '../../core/models/user_model.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/app_services.dart';
import '../../data/api/api_client.dart';
import '../../data/functions/functions.dart';

class SignUpController extends GetxController{
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
  onInit(){
    Get.lazyPut(() => AppServices());
    super.onInit();
  }

  signUp() async {
    final apiClient = ApiClient();
    Map<String, dynamic> map = {
      "username": nameController.value.text,
      "email": emailController.value.text,
      "phone": phoneController.value.text,
      "password": passwordController.value.text,
    };

    var response = await apiClient.postFromApi(Constants.signUpUrl, map);
    btnController.stop();

    if (response["result"] != null) {
      Get.toNamed(AppRoutes.menuRoute);
      UserModel userModel = UserModel.fromJson(response["result"]);
      addInGetStorage(key: Constants.currentUser, data: userModel);
      appServices.setCurrentUser();
    } else {
      appSnackBar("error", "authentication_failed".tr, response["error"]);
    }
  }
}