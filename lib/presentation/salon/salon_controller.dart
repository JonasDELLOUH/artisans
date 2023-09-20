import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/functions/app_functions.dart';
import '../../core/models/post_model.dart';
import '../../core/models/salon_model.dart';
import '../../core/models/story_model.dart';
import '../../core/services/app_services.dart';
import '../../data/data_models/get_posts_data.dart';
import '../../data/data_models/get_stories_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class SalonController extends GetxController {
  RxBool isLiked = false.obs;
  Rxn<SalonModel> salon = Rxn<SalonModel>();
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<StoryModel>> stories = Rx<List<StoryModel>>([]);
  RxBool postIsInLoading = false.obs;
  RxBool storyIsInLoading = false.obs;
  RxDouble betweenDistance = 0.0.obs;
  final appServices = Get.find<AppServices>();

  @override
  void onInit() {
    super.onInit();
    salon.value = Get.arguments[0];
    betweenDistance.value = calculateDistance(
        salon.value?.latitude ?? 0, salon.value?.longitude ?? 0, appServices.latitude.value, appServices.longitude.value);
    getPosts();
    getStories();
  }

  getPosts() async {
    try {
      postIsInLoading.value = true;
      GetPostsData getPostsData =
          await ApiServices.getPosts(salonId: salon.value?.salonId ?? "");
      posts.value = getPostsData.posts ?? [];
      debugPrint("taille de posts : ${posts.value.length}");
      postIsInLoading.value = false;
    } catch (e) {
      postIsInLoading.value = false;
      debugPrint("getPosts error:  $e");
      if (e is DioException) {
        appSnackBar("error", "Échoué", "${e.response?.data}");
      }
    }
  }

  getStories() async {
    try {
      storyIsInLoading.value = true;
      GetStoriesData getStoriesData =
          await ApiServices.getStories(salonId: salon.value?.salonId ?? "");
      stories.value = getStoriesData.stories ?? [];
      debugPrint("taille de stories : ${stories.value.length}");
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
