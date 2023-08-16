import 'package:artisans/core/models/salon_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/job_model.dart';
import '../../core/services/app_services.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);
  Rx<List<SalonModel>> nearestSalons = Rx<List<SalonModel>>([]);
  RxBool jobIsInLoading = true.obs;
  final appServices = Get.find<AppServices>();

  @override
  onInit() {
    super.onInit();
    getJob();
  }

  getJob() async {
    try {
      jobIsInLoading.value = true;
      jobs.value = (await ApiServices.getJobs()).jobs ?? [];
      appServices.setJobs(jobs.value);
      jobIsInLoading.value = false;
    } catch (e) {
      print(e);
      if (e is DioException) {
        appSnackBar("error", "Échoué", "${e.response?.data}");
      }
      jobIsInLoading.value = false;
    }
  }
}
