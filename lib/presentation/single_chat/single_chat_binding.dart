import 'package:artisans/data/services/app_services.dart';
import 'package:artisans/presentation/single_chat/single_chat_controller.dart';
import 'package:get/get.dart';

class SingleChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SingleChatController());
    Get.lazyPut(() => AppServices());
  }

}