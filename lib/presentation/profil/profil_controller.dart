import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../core/services/app_services.dart';
import '../../core/services/my_get_storage.dart';

class ProfileController extends GetxController{
  final appServices = Get.find<AppServices>();

  @override
  void onInit() {
    super.onInit();
    print("ProfileController hasSalon : ${appServices.hasSalon.value}");
  }

  logout(){
    MyGetStorage.instance.remove(Constants.currentSalon);
    MyGetStorage.instance.remove(Constants.currentUser);
    MyGetStorage.instance.remove(Constants.token);
    Get.offAllNamed(AppRoutes.signInRoute);
  }
}