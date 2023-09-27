import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/functions/app_functions.dart';
import '../../core/models/post_model.dart';
import '../../core/models/salon_model.dart';
import '../../core/models/story_model.dart';
import '../../core/services/app_services.dart';
import '../../data/data_models/get_posts_data.dart';
import '../../data/data_models/get_stories_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';
import '../../secret.dart';

class SalonController extends GetxController {
  RxBool isLiked = false.obs;
  Rxn<SalonModel> salon = Rxn<SalonModel>();
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<StoryModel>> stories = Rx<List<StoryModel>>([]);
  RxBool postIsInLoading = false.obs;
  RxBool storyIsInLoading = false.obs;
  RxDouble betweenDistance = 0.0.obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  final appServices = Get.find<AppServices>();
  Rx<StaticMapController> locationController = Rx<StaticMapController>(
      const StaticMapController(
          googleApiKey: Secret.googleApiKey,
          width: 300,
          height: 264,
          center: Location(0.0, 0.0),
          zoom: 10));

  @override
  void onInit() {
    super.onInit();
    salon.value = Get.arguments[0];
    betweenDistance.value = calculateDistance(
        salon.value?.latitude ?? 0,
        salon.value?.longitude ?? 0,
        appServices.latitude.value,
        appServices.longitude.value);
    updateLocation();
    getPosts();
    getStories();
  }

  void launchGoogleMaps(double lat, double long) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$long';

    if (!await launchUrl(
      Uri.parse(googleMapsUrl),
      mode: LaunchMode.platformDefault,
    )) {
      throw Exception('Could not launch $googleMapsUrl');
    }
  }

  updateLocation() async {
    latitude.value = salon.value?.latitude ?? 0;
    longitude.value = salon.value?.longitude ?? 0;
    locationController.value = StaticMapController(
        googleApiKey: Secret.googleApiKey,
        width: (Get.width * 0.7).toInt(),
        height: 264,
        center: Location(latitude.value, longitude.value),
        zoom: 10);
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
      debugPrint("getStories error:  $e");
      if (e is DioException) {
        appSnackBar("error", "Échoué", "${e.response?.data}");
      }
    }
  }
}
