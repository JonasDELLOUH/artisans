import 'package:artisans/data/services/app_services.dart';
import 'package:artisans/presentation/posts/posts_controller.dart';
import 'package:get/get.dart';

import '../stories/stories_controller.dart';

class PostsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PostsController());
    Get.lazyPut(() => AppServices());
  }

}