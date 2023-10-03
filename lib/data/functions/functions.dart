import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/data/services/app_services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/constants/constants.dart';
import '../../core/functions/app_functions.dart';

setHeadersWithToken({bool isWithFile = false}) async {
  AppServices appServices = AppServices();
  return {
    'Content-Type':
        isWithFile ? 'multipart/form-data' : 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Authorization': "Bearer ${getInGetStorage(key: Constants.token)}",
  };
}

appSnackBar(String type, title, message) {
  switch (type) {
    case "success":
      Get.snackbar(title, message,
          snackPosition: SnackPosition.TOP,
          colorText: whiteColor,
          backgroundColor: greenColor);
      break;
    case "error":
      Get.snackbar(title, message ?? "",
          snackPosition: SnackPosition.TOP,
          colorText: whiteColor,
          backgroundColor: redColor);
      break;
  }
}
