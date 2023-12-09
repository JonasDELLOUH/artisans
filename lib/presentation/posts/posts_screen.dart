import 'package:artisans/core/models/post_model.dart';
import 'package:artisans/presentation/posts/posts_controller.dart';
import 'package:artisans/presentation/posts/widgets/story_card.dart';
import 'package:artisans/widgets/post_tile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../core/colors/colors.dart';
import '../../core/models/salon_model.dart';
import '../../core/models/story_model.dart';
import '../../widgets/responsive.dart';
import '../../widgets/story_tile_shimmer.dart';
import 'widgets/post_container.dart';
import 'widgets/stories.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key? key, required this.controller}) : super(key: key);
  PostsController controller = Get.find<PostsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          // floatingActionButton: ElevatedButton(
          //   onPressed: (){
          //     controller.postsPagingController.refresh();
          //     controller.storiesPagingController.refresh();
          //   },
          //   style: const ButtonStyle(
          //       elevation: MaterialStatePropertyAll<double>(0),
          //       iconColor: MaterialStatePropertyAll<Color>(blueColor),
          //       iconSize: MaterialStatePropertyAll<double>(40),
          //       backgroundColor:
          //       MaterialStatePropertyAll<Color>(Colors.transparent)),
          //   child: const Icon(Icons.refresh),
          // ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  height: 200.0,
                  color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
                  child: Row(
                    children: [
                      Obx(() =>
                      (controller.appServices.hasSalon.value == true)
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: StoryCard(
                          isAddStory: true,
                          story: StoryModel(
                              content: "", salonId: "", videoUrl: "", id: ""),
                          currentSalon: controller.appServices.currentSalon.value!,
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
                ),
                Expanded(
                    child: RefreshIndicator(
                      color: blueColor,
                      key: controller.refreshIndicatorKey,
                      onRefresh:() async{
                        controller.postsPagingController.refresh();
                        controller.storiesPagingController.refresh();
                      },
                      child: PagedListView<int, PostModel>(
                          pagingController: controller.postsPagingController,
                          builderDelegate: PagedChildBuilderDelegate<PostModel>(
                              firstPageProgressIndicatorBuilder: (_) =>
                              const SingleChildScrollView(
                                child: Column(
                                  children: [
                                    PostTileShimmer(),
                                    PostTileShimmer(),
                                    PostTileShimmer(),
                                    PostTileShimmer(),
                                  ],
                                ),
                              ),
                              newPageProgressIndicatorBuilder: (_) =>
                              const SingleChildScrollView(
                                child: Column(
                                  children: [
                                    PostTileShimmer(),
                                    PostTileShimmer(),
                                  ],
                                ),
                              ),
                              itemBuilder: (context, item, index) =>
                                  PostContainer(postModel: item))),
                    )),
              ],
            ),
          ),
        ),

    );
  }
}
