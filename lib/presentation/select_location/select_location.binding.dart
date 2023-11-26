import 'package:artisans/presentation/select_location/select_location.controller.dart';
import 'package:get/get.dart';

class SelectLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectLocationController());
  }
}
