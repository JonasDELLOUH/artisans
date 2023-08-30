import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../core/models/story_model.dart';
import '../../data/data_models/get_stories_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class StoriesController extends GetxController{
  Rx<List<StoryModel>> stories = Rx<List<StoryModel>>([]);
  RxBool storyIsInLoading = false.obs;
  RxString salonId = "".obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    salonId.value = Get.arguments != null && Get.arguments is List && Get.arguments.isNotEmpty
        ? Get.arguments[0]
        : "";
    getStories();
  }

  updateLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  getStories() async {
    try {
      storyIsInLoading.value = true;
      await updateLocation();
      GetStoriesData getStoriesData = await ApiServices.getStories(
          lat: latitude.value, long: longitude.value);
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