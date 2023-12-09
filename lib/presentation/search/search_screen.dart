import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/models/salon_model.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:artisans/widgets/no_salon_find_view.dart';
import 'package:artisans/widgets/search_text_field.dart';
import 'package:artisans/presentation/search/widgets/search_job_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../widgets/salon_tile.dart';
import '../../widgets/salon_tile_shimer.dart';
import '../search/search_controller.dart' as search_controller;

class SearchScreen extends GetView<search_controller.SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: CustomText(
          text: "search".tr,
        ),
        leading: const BackButton(
          color: blueColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: SearchTextField(
                  controller: controller.searchController,
                  onEditingComplete: () {
                    controller.salonsPagingController.refresh();
                  },
                )),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () {
                      controller.searchController.clear();
                    },
                    child: const Icon(
                      Icons.clear,
                      size: 30,
                      color: greyColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 30,
                child: Obx(() => controller.jobIsInLoading.value
                    ? LinearProgressIndicator(
                        color: greyColor.withOpacity(0.4),
                        backgroundColor: whiteColor,
                      )
                    : controller.jobs.value.isEmpty
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.jobs.value.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Obx(() => SearchJobTile(
                                    jobModel: controller.jobs.value[index],
                                    isSelected:
                                        controller.jobs.value[index].jobId ==
                                            controller.jobId.value,
                                    onTap: () {
                                      controller.jobId.value =
                                          controller.jobs.value[index].jobId;
                                      controller.salonsPagingController
                                          .refresh();
                                    },
                                  ));
                            }))),
            const SizedBox(
              height: 10,
            ),
            Obx(() => CustomText(
                  text:
                      "${"result_found".tr}(${controller.length.toString() ?? ""})",
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: PagedListView<int, SalonModel>(
                    pagingController: controller.salonsPagingController,
                    builderDelegate: PagedChildBuilderDelegate<SalonModel>(
                        firstPageProgressIndicatorBuilder: (_) =>
                            const SingleChildScrollView(
                              child: Column(
                                children: [
                                  SalonTileShimmer(),
                                  SalonTileShimmer(),
                                  SalonTileShimmer(),
                                  SalonTileShimmer(),
                                ],
                              ),
                            ),
                        newPageProgressIndicatorBuilder: (_) =>
                            const SingleChildScrollView(
                              child: Column(
                                children: [
                                  SalonTileShimmer(),
                                  SalonTileShimmer(),
                                ],
                              ),
                            ),
                        noItemsFoundIndicatorBuilder: (_) =>
                            const NoSalonFindView(),
                        itemBuilder: (context, item, index) => SalonTile(
                              salonModel: item,
                              latitude: controller.latitude.value,
                              longitude: controller.longitude.value,
                            )))),
          ],
        ),
      ),
    );
  }
}
