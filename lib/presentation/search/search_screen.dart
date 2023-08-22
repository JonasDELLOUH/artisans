import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:artisans/widgets/no_salon_find_view.dart';
import 'package:artisans/widgets/search_text_field.dart';
import 'package:artisans/presentation/search/widgets/search_job_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/salon_tile.dart';
import '../search/search_controller.dart' as search_controller;

class SearchScreen extends GetView<search_controller.SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    controller.getSalons();
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
                                      controller.getSalons();
                                    },
                                  ));
                            }))),
            const SizedBox(
              height: 10,
            ),
            Obx(() => CustomText(
                  text:
                      "${"result_found".tr}(${controller.salons.value.length.toString()})",
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Obx(() => controller.getSalonsIsInLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.jobs.value.isEmpty
                        ? const NoSalonFindView()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.salons.value.length,
                            itemBuilder: (context, index) {
                              return SalonTile(
                                salonModel: controller.salons.value[index],
                                latitude: controller.latitude.value,
                                longitude: controller.longitude.value,
                              );
                            }))),
          ],
        ),
      ),
    );
  }
}
