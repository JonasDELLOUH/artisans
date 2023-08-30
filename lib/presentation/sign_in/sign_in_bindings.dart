import 'package:artisans/core/services/app_services.dart';
import 'package:artisans/presentation/sign_in/sign_in_controller.dart';
import 'package:get/get.dart';

class SignInBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    // Get.lazyPut(() => AppServices());
  }

}