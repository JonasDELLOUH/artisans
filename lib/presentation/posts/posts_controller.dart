import 'package:artisans/core/models/post_model.dart';
import 'package:artisans/data/data_models/get_posts_data.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class PostsController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  RxBool postIsInLoading = true.obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPosts();
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
}
