import 'package:artisans/core/models/salon_model.dart';
import 'package:artisans/core/models/story_model.dart';
import 'package:artisans/data/services/app_services.dart';
import 'package:artisans/widgets/responsive.dart';
import 'package:artisans/presentation/posts/widgets/story_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/data_models/get_stories_data.dart';
import '../../../data/services/api_services.dart';
import '../../../widgets/story_tile_shimmer.dart';
import '../posts_controller.dart';

class Stories extends StatelessWidget {
  final appServices = Get.find<AppServices>();
  final bool isSingleSalon;
  StoriesController controller;

  Stories({Key? key, this.isSingleSalon = false, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
      child: Row(
        children: [
          Obx(() =>
              (appServices.hasSalon.value == true && isSingleSalon == false)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: StoryCard(
                        isAddStory: true,
                        story: StoryModel(
                            content: "", salonId: "", videoUrl: "", id: ""),
                        currentSalon: appServices.currentSalon.value!,
                      ),
                    )
                  : Container()),
          Expanded(
            child: PagedListView<int, StoryModel>(
              scrollDirection: Axis.horizontal,
              pagingController: controller.storiesPagingController,
              builderDelegate: PagedChildBuilderDelegate<StoryModel>(
                itemBuilder: (context, item, index) => StoryCard(
                  story: item,
                  currentSalon: SalonModel.currentSalon(),
                ),
                  firstPageProgressIndicatorBuilder: (_) => const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StoryTileShimmer(),
                        StoryTileShimmer(),
                        StoryTileShimmer(),
                        StoryTileShimmer(),
                      ],
                    ),
                  ),
                  newPageProgressIndicatorBuilder: (_) => const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StoryTileShimmer(),
                        StoryTileShimmer(),
                      ],
                    ),
                  ),
                noItemsFoundIndicatorBuilder: (_) => Container()
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StoriesController extends GetxController {
  final PagingController<int, StoryModel> storiesPagingController =
      PagingController(firstPageKey: 0);
  String? salonId;
  final appServices = Get.find<AppServices>();


  StoriesController({this.salonId}) {
    Get.put(AppServices());
    storiesPagingController.addPageRequestListener((pageKey) {
      fetchStories(pageKey);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // storiesPagingController.addPageRequestListener((pageKey) {
    //   fetchStories(pageKey);
    // });
  }

  // Future<void> fetchPosts(int pageKey) async {
  //   try {
  //     // await appServices.checkLocationPermissionAndFetchLocation();
  //     GetPostsData getPostsData = await ApiServices.getPosts(
  //         lat: appServices.latitude.value, long: appServices.longitude.value, skip: pageKey, limit: 5);
  //     final newItems = getPostsData.posts ?? [];
  //     final isLastPage = newItems.length < 5;
  //     if (isLastPage) {
  //       postsPagingController.appendLastPage(newItems);
  //     } else {
  //       final nextPageKey = pageKey + newItems.length;
  //       postsPagingController.appendPage(newItems, nextPageKey);
  //     }
  //   } catch (error) {
  //     postsPagingController.error = error;
  //   }
  // }

  Future<void> fetchStories(int pageKey) async {
    try {
      // await appServices.checkLocationPermissionAndFetchLocation();
      GetStoriesData getStoriesData = await ApiServices.getStories(
          lat: appServices.latitude.value,
          long: appServices.longitude.value,
          skip: pageKey,
          limit: 5,
          salonId: salonId);
      final newItems = getStoriesData.stories ?? [];
      final isLastPage = newItems.length < 5;
      if (isLastPage) {
        storiesPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        storiesPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      storiesPagingController.error = error;
    }
  }
}
