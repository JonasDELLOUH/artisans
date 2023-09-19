import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../core/models/post_model.dart';
import '../../core/models/salon_model.dart';
import '../../core/models/story_model.dart';
import '../../data/data_models/get_posts_data.dart';
import '../../data/data_models/get_stories_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class SalonController extends GetxController {
  RxBool isLiked = false.obs;
  RxString salonId = "".obs;
  Rxn<SalonModel> salon = Rxn<SalonModel>();
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<StoryModel>> stories = Rx<List<StoryModel>>([]);
  RxBool postIsInLoading = false.obs;
  RxBool storyIsInLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // salonId.value = Get.arguments != null &&
    //         Get.arguments is List &&
    //         Get.arguments.isNotEmpty
    //     ? Get.arguments[0]
    //     : "";
    salon.value = Get.arguments[0];
    getPosts();
    getStories();
  }

  getPosts() async {
    try {
      postIsInLoading.value = true;
      GetPostsData getPostsData =
          await ApiServices.getPosts(salonId: salonId.value);
      posts.value = getPostsData.posts ?? [];
      print("taille de posts : ${posts.value.length}");
      postIsInLoading.value = false;
    } catch (e) {
      postIsInLoading.value = false;
      print("getPosts error:  $e");
      if (e is DioException) {
        appSnackBar("error", "Échoué", "${e.response?.data}");
      }
    }
  }

  getStories() async {
    try {
      storyIsInLoading.value = true;
      GetStoriesData getStoriesData =
          await ApiServices.getStories(salonId: salonId.value);
      stories.value = getStoriesData.stories ?? [];
      print("taille de stories : ${stories.value.length}");
      storyIsInLoading.value = false;
    } catch (e) {
      storyIsInLoading.value = false;
      print("getStories error:  $e");
      if (e is DioException) {
        appSnackBar("error", "Échoué", "${e.response?.data}");
      }
    }
  }
}
