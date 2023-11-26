import 'package:artisans/presentation/select_own_location_on_map/select_own_location_on_map.controller.dart';
import 'package:get/get.dart';

class SelectOwnLocationOnMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectOwnLocationOnMapController());
  }
}
