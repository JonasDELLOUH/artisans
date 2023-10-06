import 'package:artisans/presentation/posts/posts_controller.dart';
import 'package:artisans/widgets/post_tile_shimmer.dart';
import 'package:artisans/widgets/story_tile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../core/colors/colors.dart';
import 'widgets/post_container.dart';
import 'widgets/stories.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key? key, required this.controller}) : super(key: key);
  PostsController controller = Get.find<PostsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton: ElevatedButton(
            onPressed: controller.onRefresh,
            style: const ButtonStyle(
              elevation: MaterialStatePropertyAll<double>(0),
                iconColor: MaterialStatePropertyAll<Color>(blueColor),
                iconSize: MaterialStatePropertyAll<double>(40),
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent)),
            child: const Icon(Icons.refresh),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: CustomScrollView(
              // shrinkWrap: false,
              // physics:
              // const NeverScrollableScrollPhysics(),
              slivers: [
                Obx(() => controller.storyIsInLoading.value
                    ? const SliverPadding(
                        padding: EdgeInsets.zero,
                        sliver: SliverToBoxAdapter(
                            child: SizedBox(
                          child: SingleChildScrollView(
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
                        )),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                        sliver: SliverToBoxAdapter(
                          child: Stories(
                            stories: controller.stories.value,
                          ),
                        ),
                      )),
                Obx(() => controller.postIsInLoading.value
                    ? const SliverPadding(
                        padding: EdgeInsets.zero,
                        sliver: SliverToBoxAdapter(
                            child: SizedBox(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                PostTileShimmer(),
                                PostTileShimmer(),
                                PostTileShimmer(),
                                PostTileShimmer(),
                              ],
                            ),
                          ),
                        )),
                      )
                    : controller.posts.value.isEmpty
                        ? SliverPadding(
                            padding: EdgeInsets.zero,
                            sliver: SliverToBoxAdapter(
                              child: Container(),
                            ))
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return PostContainer(
                                    postModel: controller.posts.value[index]);
                              },
                              childCount: controller.posts.value.length,
                            ),
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
