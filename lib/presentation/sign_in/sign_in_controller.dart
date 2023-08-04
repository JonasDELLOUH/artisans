import 'package:artisans/core/models/user_model.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/constants/constants.dart';
import '../../core/functions/app_functions.dart';
import '../../core/services/app_services.dart';
import '../../data/api/api_client.dart';
import '../../data/functions/functions.dart';

class SignInController extends GetxController{
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();
  final appServices = Get.find<AppServices>();
  RxBool passwordIsVisible = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  onInit(){
    Get.lazyPut(() => AppServices());
    super.onInit();
  }

  signIn() async {
    final apiClient = ApiClient();
    Map<String, dynamic> map = {
      "username": usernameController.value.text,
      "password": passwordController.value.text
    };

    var response = await apiClient.postFromApi(Constants.signInUrl, map);
    btnController.stop();

    if (response["result"] != null) {
      Get.toNamed(AppRoutes.menuRoute);
      UserModel userModel = UserModel.fromJson(response["result"]);
      addInGetStorage(key: Constants.currentUser, data: userModel.toJson());
      appServices.setCurrentUser();
    } else {
      appSnackBar("error", "authentication_failed".tr, response["error"]);
    }
  }
}