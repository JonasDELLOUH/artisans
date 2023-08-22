import 'package:artisans/core/models/salon_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../core/models/job_model.dart';
import '../../core/services/app_services.dart';
import '../../data/data_models/get_salons_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class SearchController extends GetxController{
  TextEditingController searchController = TextEditingController();
  RxBool getSalonsIsInLoading = false.obs;
  Rx<List<SalonModel>> salons = Rx<List<SalonModel>>([]);
  RxString jobId = "".obs;

  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);
  RxBool jobIsInLoading = true.obs;
  final appServices = Get.find<AppServices>();

  @override
  void onInit() {
    super.onInit();
    getJob();
    getSalons();
  }

  getJob() async {
    jobIsInLoading.value = true;
    jobs.value.add(JobModel(jobImageUrl: "", jobName: "all".tr, jobId: ""));
    jobs.value.addAll(appServices.jobs.value);
    jobIsInLoading.value = false;
  }

  getSalons() async {
    try {
      getSalonsIsInLoading.value = true;
      GetSalonsData getSalonsData = await ApiServices.getSalons(name: searchController.value.text, jobId: jobId.value);
      salons.value = getSalonsData.salons ?? [];
      getSalonsIsInLoading.value = false;
    } catch (e) {
      getSalonsIsInLoading.value = false;
      print(e);
      if (e is DioException) {
        appSnackBar("error", "Échoué", "${e.response?.data}");
      }
    }
  }
}