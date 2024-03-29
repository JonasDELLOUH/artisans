import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/widgets/job_tile_shimmer.dart';
import 'package:artisans/widgets/salon_tile.dart';
import 'package:artisans/widgets/custom_button.dart';
import 'package:artisans/widgets/custom_image_network.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:artisans/widgets/salon_tile_shimer.dart';
import 'package:artisans/widgets/search_text_field.dart';
import 'package:artisans/presentation/home/home_controller.dart';
import 'package:artisans/presentation/home/widgets/job_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.controller}) : super(key: key);
  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => controller.appServices.hasSalon.value
                          ? CustomImageNetwork(
                              imageUrl: Constants.imageOriginUrl +
                                  controller
                                      .appServices.currentSalon.value!.imageUrl,
                              height: 30,
                              width: 30,
                              borderRadius: BorderRadius.circular(10),
                            )
                          : Container()),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.salonsMapRoute,
                              arguments: [controller.nearestSalons.value]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: blueColor.withOpacity(0.05),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: blueColor),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on, color: blueColor),
                              CustomText(
                                text: "nearest".tr,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      )
                      // const Row(
                      //   children: [
                      //     CustomIcon(
                      //       icon: Icons.notifications_none,
                      //     ),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     CustomIcon(
                      //       icon: Icons.message,
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.searchRoute);
                    },
                    child: SearchTextField(
                      enabled: false,
                      controller: controller.searchController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 72,
                    child: Obx(() => controller.jobIsInLoading.value
                        ? const SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                JobTileShimmer(),
                                JobTileShimmer(),
                                JobTileShimmer(),
                                JobTileShimmer(),
                                JobTileShimmer(),
                                JobTileShimmer(),
                              ],
                            ),
                          )
                        : controller.jobs.value.isEmpty
                            ? Container()
                            : ListView.builder(
                                shrinkWrap: false,
                                itemCount: controller.jobs.value.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return JobTile(
                                    jobModel: controller.jobs.value[index],
                                    onTap: () {
                                      Get.toNamed(AppRoutes.searchRoute,
                                          arguments: [
                                            controller.jobs.value[index].jobId
                                          ]);
                                    },
                                  );
                                })),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      color: blueColor,
                      key: controller.refreshIndicatorKey,
                      onRefresh: () async {
                        controller.getNearestSalons();
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 150,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: greyColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      height: 130,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(() => CustomText(
                                                text:
                                                    "${(controller.starSalon.value!.nbrStar * 100 / 5).toString()} %",
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          Obx(() => CustomText(
                                                text:
                                                    "${controller.starSalon.value?.salonName}",
                                                fontSize: 13,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                              )),
                                          CustomTextButton(
                                            text: "Consulter maintenant",
                                            fontSize: 9,
                                            onPressed: () {
                                              Get.toNamed(AppRoutes.salonRoute,
                                                  arguments: [
                                                    controller.starSalon.value
                                                  ]);
                                            },
                                            height: 27,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Obx(() => CustomImageNetwork(
                                            imageUrl: Constants.imageOriginUrl +
                                                controller
                                                    .starSalon.value!.imageUrl,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            height: 150,
                                          )))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "nearest".tr,
                                  fontWeight: FontWeight.w600,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.searchRoute);
                                  },
                                  child: CustomText(
                                    text: "view_all".tr,
                                    fontSize: 12,
                                    color: greyColor,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() => controller.getSalonsIsInLoading.value
                                ? const Column(
                                    children: [
                                      SalonTileShimmer(),
                                      SalonTileShimmer(),
                                      SalonTileShimmer(),
                                    ],
                                  )
                                : controller.nearestSalons.value.isEmpty
                                    ? Container()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                            .nearestSalons.value.length,
                                        itemBuilder: (context, index) {
                                          return SalonTile(
                                            salonModel: controller
                                                .nearestSalons.value[index],
                                            latitude: controller
                                                .appServices.latitude.value,
                                            longitude: controller
                                                .appServices.longitude.value,
                                          );
                                        })),
                          ],
                        ),
                      ),
                    ),
                  )
                ]))));
  }
}
