import 'package:artisans/data/services/app_services.dart';
import 'package:artisans/presentation/salons_map/salons_map_controller.dart';
import 'package:get/get.dart';

class SalonsMapBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SalonsMapController());
    Get.lazyPut(() => AppServices());
  }

}