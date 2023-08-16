import "package:artisans/core/services/app_services.dart";
import "package:artisans/presentation/menu/menu_controller.dart";
import "package:get/get.dart";
class MenuBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MenuController());
    Get.lazyPut(() => AppServices());
  }

}