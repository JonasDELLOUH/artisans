import 'package:artisans/data/services/app_services.dart';
import 'package:artisans/presentation/create_salon/create_salon_controller.dart';
import 'package:get/get.dart';

class CreateSalonBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CreateSalonController());
    Get.put(() => AppServices());
  }

}