import 'package:artisans/core/models/post_model.dart';
import 'package:artisans/core/models/story_model.dart';
import 'package:artisans/data/data_models/get_posts_data.dart';
import 'package:artisans/data/data_models/get_stories_data.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class PostsController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<StoryModel>> stories = Rx<List<StoryModel>>([]);
  RxBool postIsInLoading = false.obs;
  RxBool storyIsInLoading = false.obs;
  RxString salonId = "".obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    salonId.value = Get.arguments != null && Get.arguments is List && Get.arguments.isNotEmpty
        ? Get.arguments[0]
        : "";
    getPosts();
    getStories();
  }

  updateLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  getPosts() async {
    try {
      postIsInLoading.value = true;
      await updateLocation();
      GetPostsData getPostsData = await ApiServices.getPosts(
          lat: latitude.value, long: longitude.value);
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
      await updateLocation();
      GetStoriesData getStoriesData = await ApiServices.getStories(
          lat: latitude.value, long: longitude.value);
      stories.value = getStoriesData.stories ?? [];
      print("taille de stories : ${posts.value.length}");
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
