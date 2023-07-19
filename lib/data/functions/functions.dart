
import 'package:artisans/core/colors/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

setHeadersWithToken() async => {
  'Content-Type': 'application/json; charset=UTF-8',
  // 'Content-Type': 'multipart/form-data',
  'Accept': 'application/json',
  // 'Authorization': 'Bearer' + " " + (await getToken()),
};

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