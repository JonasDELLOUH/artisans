import 'package:artisans/core/models/post_model.dart';
import 'package:artisans/presentation/posts/posts_controller.dart';
import 'package:artisans/widgets/post_tile_shimmer.dart';
import 'package:artisans/widgets/story_tile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.transparent)),
            child: const Icon(Icons.refresh),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Stories(
                  controller: Get.put(StoriesController()),
                ),
                Expanded(
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
                                PostContainer(postModel: item)))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
