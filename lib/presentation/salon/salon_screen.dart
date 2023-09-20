import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/widgets/custom_icon.dart';
import 'package:artisans/widgets/custom_image_network.dart';
import 'package:artisans/presentation/salon/salon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/post_tile_shimmer.dart';
import '../../widgets/stars_tile.dart';
import '../../widgets/story_tile_shimmer.dart';
import '../posts/widgets/post_container.dart';
import '../posts/widgets/stories.dart';

class SalonScreen extends GetView<SalonController> {
  const SalonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height * 0.35,
            child: Stack(
              children: [
                CustomImageNetwork(
                  imageUrl:
                      Constants.imageOriginUrl + controller.salon.value!.imageUrl,
                  borderRadius: BorderRadius.zero,
                  width: Get.width,
                ),
                Positioned(
                    top: 0,
                    left: 15,
                    right: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButton(
                          color: whiteColor,
                        ),
                        Obx(() => IconButton(
                              icon: const Icon(Icons.star, size: 30),
                              color: controller.isLiked.value
                                  ? goldenColor
                                  : whiteColor,
                              onPressed: () {
                                controller.isLiked.value =
                                    !controller.isLiked.value;
                              },
                            ))
                      ],
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Get.height * 0.3 - 20),
            height: Get.height * 0.65,
            padding: const EdgeInsets.all(15),
            width: Get.width,
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                   Row(
                    children: [
                      const CustomIcon(
                        icon: Icons.location_on,
                        iconSize: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Obx(() => CustomText(
                        text: "${controller.salon.value?.address} ${"at".tr} ${(controller.betweenDistance.value >= 1000)
                            ? "${(controller.betweenDistance.value / 1000).toStringAsFixed(2)} km"
                            : "${controller.betweenDistance.value.toStringAsFixed(2)} m"}",
                        fontSize: 10,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   CustomText(
                    text: "${controller.salon.value?.salonName}",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: stars(controller.salon.value?.nbrStar ?? 0),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const CustomText(
                        text: "110 golds",
                        fontSize: 10,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   CustomText(
                    text: "${controller.salon.value?.desc}",
                    fontSize: 12,
                    color: greyColor,
                    maxLines: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  contactWidget(
                      contactType: 'E-MAIL',
                      contactValue: "${controller.salon.value?.email}",
                      contactIcon: Icons.email),
                  contactWidget(
                      contactType: 'phone'.tr,
                      contactValue: "${controller.salon.value?.phone}",
                      contactIcon: Icons.phone),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    slivers: [
                      Obx(() => controller.storyIsInLoading.value
                          ?  const SliverPadding(
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
                            )
                        ),
                      )
                          : SliverPadding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                              sliver: SliverToBoxAdapter(
                                child: Stories(
                                  stories: controller.stories.value,
                                    isSingleSalon: true
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
                            )
                        ),
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

Widget contactWidget(
    {required String contactType,
    required String contactValue,
    required IconData contactIcon}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 7),
    child: Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: blueColor.withOpacity(0.7),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: Icon(
            contactIcon,
            color: whiteColor,
            size: 15,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: contactType.toUpperCase(),
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: greyColor,
            ),
            CustomText(
              text: contactValue,
              fontSize: 10,
            )
          ],
        )
      ],
    ),
  );
}
