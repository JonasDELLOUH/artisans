import 'package:get/get.dart';

import 'add_post_controller.dart';

class AddPostBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AddPostController());
  }

}