import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/widgets/custom_icon.dart';
import 'package:artisans/widgets/custom_image_network.dart';
import 'package:artisans/presentation/salon/salon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/data/data.dart';
import '../../core/models/post_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/stars_tile.dart';
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
                      "https://images.unsplash.com/photo-1525253086316-d0c936c814f8",
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
                  const Row(
                    children: [
                      CustomIcon(
                        icon: Icons.location_on,
                        iconSize: 15,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: "Calavi Zogbadje, ...",
                        fontSize: 10,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomText(
                    text: "Jim Jax Coiffure",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: stars(5),
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
                  const CustomText(
                    text: "Bienvenue dans notre salon de coiffure"
                        " haut de gamme et tendance, où l'art "
                        "et la créativité se marient pour sublimer"
                        " votre beauté. Chez nous, nous mettons l'accent "
                        "sur l'excellence et l'innovation, en vous "
                        "offrant une expérience de coiffure unique et "
                        "inoubliable.",
                    fontSize: 12,
                    color: greyColor,
                    maxLines: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  contactWidget(
                      contactType: 'E-MAIL',
                      contactValue: "jdellouh1@gmail.com",
                      contactIcon: Icons.email),
                  contactWidget(
                      contactType: 'phone'.tr,
                      contactValue: "+229 96133525",
                      contactIcon: Icons.phone),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                        sliver: SliverToBoxAdapter(
                          child: Stories(
                            currentUser: currentUser,
                            stories: stories,
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final Post post = posts[index];
                            return PostContainer(post: post);
                          },
                          childCount: posts.length,
                        ),
                      ),
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
