import 'package:artisans/core/models/salon_model.dart';
import 'package:artisans/presentation/posts/posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/data/data.dart';
import 'widgets/post_container.dart';
import 'widgets/stories.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key? key, required this.controller}) : super(key: key);
  PostsController controller = Get.find<PostsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TextButton(
        onPressed: () {
          controller.getPosts();
          controller.getStories();
        },
        child: const Text("get posts"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: CustomScrollView(
          slivers: [
            Obx(() => controller.storyIsInLoading.value
                ? const SliverPadding(
                    padding: EdgeInsets.zero,
                    sliver: SliverToBoxAdapter(
                        child: Center(
                      child: CircularProgressIndicator(),
                    )),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    sliver: SliverToBoxAdapter(
                      child: Stories(
                        stories: controller.stories.value, currentSalon: SalonModel.currentSalon(),
                      ),
                    ),
                  )),
            Obx(() => controller.postIsInLoading.value
                ? const SliverPadding(
                    padding: EdgeInsets.zero,
                    sliver: SliverToBoxAdapter(
                        child: Center(
                      child: CircularProgressIndicator(),
                    )),
                  )
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
      )),
    );
  }
}
