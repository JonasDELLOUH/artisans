import 'package:artisans/presentation/update_salon/update_salon_controller.dart';
import 'package:get/get.dart';

class UpdateSalonBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => UpdateSalonController());
  }

}