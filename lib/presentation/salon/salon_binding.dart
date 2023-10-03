import 'package:artisans/data/services/app_services.dart';
import 'package:artisans/presentation/salon/salon_controller.dart';
import 'package:get/get.dart';

class SalonBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SalonController());
    Get.lazyPut(() => AppServices());
  }

}