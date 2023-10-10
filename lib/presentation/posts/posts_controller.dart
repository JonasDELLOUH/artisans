import 'package:artisans/core/models/post_model.dart';
import 'package:artisans/core/models/story_model.dart';
import 'package:artisans/data/data_models/get_posts_data.dart';
import 'package:artisans/data/data_models/get_stories_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';
import '../../data/services/app_services.dart';

class PostsController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<StoryModel>> stories = Rx<List<StoryModel>>([]);
  RxBool postIsInLoading = false.obs;
  RxBool storyIsInLoading = false.obs;
  RxString salonId = "".obs;
  final appServices = Get.find<AppServices>();

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  final PagingController<int, PostModel> postsPagingController =
  PagingController(firstPageKey: 0);



  @override
  void onInit() {
    super.onInit();
    salonId.value = Get.arguments != null && Get.arguments is List && Get.arguments.isNotEmpty
        ? Get.arguments[0]
        : "";

    postsPagingController.addPageRequestListener((pageKey) {
      fetchPosts(pageKey);
    });
    // getPosts();
    // getStories();
  }

  Future<void> fetchPosts(int pageKey) async {
    try {
      await appServices.checkLocationPermissionAndFetchLocation();
      GetPostsData getPostsData = await ApiServices.getPosts(
          lat: appServices.latitude.value, long: appServices.longitude.value, skip: pageKey, limit: 5);
      final newItems = getPostsData.posts ?? [];
      final isLastPage = newItems.length < 5;
      if (isLastPage) {
        postsPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        postsPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      postsPagingController.error = error;
    }
  }


  void onRefresh() async {
    try {
      await appServices.checkLocationPermissionAndFetchLocation();
      GetPostsData getPostsData = await ApiServices.getPosts(
          lat: appServices.latitude.value, long: appServices.longitude.value);
      posts.value = getPostsData.posts ?? [];
      GetStoriesData getStoriesData = await ApiServices.getStories(
          lat: appServices.latitude.value, long: appServices.longitude.value);
      stories.value = getStoriesData.stories ?? [];
      refreshController.refreshCompleted();
    } catch(e){
      refreshController.refreshFailed();
      if (e is DioException) {
        appSnackBar("error", "Échoué", "${e.response?.data}");
      }
    }
  }

  getPosts() async {
    try {
      postIsInLoading.value = true;
      await appServices.checkLocationPermissionAndFetchLocation();
      GetPostsData getPostsData = await ApiServices.getPosts(
          lat: appServices.latitude.value, long: appServices.longitude.value);
      posts.value = getPostsData.posts ?? [];
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
      await appServices.checkLocationPermissionAndFetchLocation();
      GetStoriesData getStoriesData = await ApiServices.getStories(
          lat: appServices.latitude.value, long: appServices.longitude.value);
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
