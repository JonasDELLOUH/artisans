import 'package:artisans/presentation/salon/salon_controller.dart';
import 'package:get/get.dart';

class SalonBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SalonController());
  }

}