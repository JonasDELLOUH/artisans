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
          // ListView.builder(
          //   padding: const EdgeInsets.symmetric(
          //     vertical: 10.0,
          //     horizontal: 8.0,
          //   ),
          //   scrollDirection: Axis.horizontal,
          //   itemCount: 1 + stories.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     if (index == 0) {
          //       return Obx(() =>
          //           (appServices.hasSalon.value == true && isSingleSalon == false)
          //               ? Padding(
          //                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
          //                   child: StoryCard(
          //                     isAddStory: true,
          //                     story: StoryModel(content: "", salonId: "", videoUrl: "", id: ""),
          //                     currentSalon: appServices.currentSalon.value!,
          //                   ),
          //                 )
          //               : Container());
          //     } else {
          //       final StoryModel story = stories[index - 1];
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
          //         child: StoryCard(
          //           story: story,
          //           currentSalon: SalonModel.currentSalon(),
          //         ),
          //       );
          //     }
          //   },
          // ),
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
                  )
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
  final appServices = Get.find<AppServices>();
  String? salonId;

  StoriesController({this.salonId}) {
    Get.put(AppServices());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    storiesPagingController.addPageRequestListener((pageKey) {
      fetchStories(pageKey);
    });
  }

  Future<void> fetchStories(int pageKey) async {
    try {
      await appServices.checkLocationPermissionAndFetchLocation();
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
