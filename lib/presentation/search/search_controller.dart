import 'dart:developer';

import 'package:artisans/core/models/salon_model.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/models/job_model.dart';
import '../../data/services/app_services.dart';
import '../../data/data_models/get_salons_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class SearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  // RxBool getSalonsIsInLoading = true.obs;
  Rx<List<SalonModel>> salons = Rx<List<SalonModel>>([]);
  RxString jobId = "".obs;

  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);
  RxBool jobIsInLoading = true.obs;
  final appServices = Get.find<AppServices>();
  RxInt length = 0.obs;

  final PagingController<int, SalonModel> salonsPagingController =
  PagingController(firstPageKey: 1);

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  @override
  void onInit() {
    latitude.value = appServices.latitude.value;
    longitude.value = appServices.longitude.value;
    super.onInit();
    jobId.value = Get.arguments != null && Get.arguments is List && Get.arguments.isNotEmpty
        ? Get.arguments[0]
        : "";
    getJob();
    salonsPagingController.addPageRequestListener((pageKey) {
      fetchSalons(pageKey);
    });
  }

  updateLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  getJob() async {
    jobIsInLoading.value = true;
    jobs.value.add(JobModel(jobImageUrl: "", jobName: "all".tr, jobId: ""));
    jobs.value.addAll(appServices.jobs.value);
    jobIsInLoading.value = false;
  }

  // getSalons() async {
  //   try {
  //     getSalonsIsInLoading.value = true;
  //     await updateLocation();
  //     GetSalonsData getSalonsData = await ApiServices.getSalons(
  //         name: searchController.value.text,
  //         jobId: jobId.value,
  //         long: longitude.value,
  //         lat: latitude.value);
  //     salons.value = getSalonsData.salons ?? [];
  //     getSalonsIsInLoading.value = false;
  //   } catch (e) {
  //     getSalonsIsInLoading.value = false;
  //     print(e);
  //     if (e is DioException) {
  //       appSnackBar("error", "Échoué", "${e.response?.data}");
  //     }
  //   }
  // }

  Future<void> fetchSalons(int pageKey) async {
    try {
      GetSalonsData getSalonsData = await ApiServices.getSalons(
          name: searchController.value.text,
          jobId: jobId.value,
          long: longitude.value,
          lat: latitude.value, page: pageKey, perPage: 2);
      salons.value = getSalonsData.salons ?? [];
      final newItems = getSalonsData.salons ?? [];

      log("\t \t \t getSalonsData.hasNext : ${getSalonsData.hasNext}");
      final isLastPage = getSalonsData.hasNext == false;
      if (isLastPage) {
        salonsPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        salonsPagingController.appendPage(newItems, nextPageKey);
      }
      length.value = salonsPagingController.itemList?.length ?? 0;
    } catch (error) {
      salonsPagingController.error = error;
    }
  }
}
