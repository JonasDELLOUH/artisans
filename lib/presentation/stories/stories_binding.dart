import 'package:artisans/presentation/stories/stories_controller.dart';
import 'package:get/get.dart';

class StoriesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => StoriesController());
  }

}