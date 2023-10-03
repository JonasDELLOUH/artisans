import 'package:artisans/core/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../data/services/app_services.dart';
import '../../data/data_models/user_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class SignInController extends GetxController {
  TextEditingController usernameController = TextEditingController(text: "JonasDELLOUH");
  TextEditingController passwordController = TextEditingController(text: "jonas1007");
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final appServices = Get.find<AppServices>();
  RxBool passwordIsVisible = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  onInit() {
    Get.lazyPut(() => AppServices());
    super.onInit();
  }

  signIn() async {
    try {
      UserData userData = (await ApiServices.loginUser(
          username: usernameController.value.text,
          password: passwordController.value.text));
      appServices.setCurrentUser(userData.userModel!, userData.token);
      await appServices.getUserSalon();
      btnController.stop();
      Get.offAllNamed(AppRoutes.menuRoute);
    } catch (e) {
      debugPrint("$e");
      if (e is DioException) {
        appSnackBar("error", "Connection échouée",
            "${e.response?.data}");
      }
      btnController.stop();
    }
  }
}
