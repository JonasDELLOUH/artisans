import 'package:artisans/core/models/salon_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../core/models/job_model.dart';
import '../../core/services/app_services.dart';
import '../../data/data_models/get_salons_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);
  Rx<List<SalonModel>> nearestSalons = Rx<List<SalonModel>>([]);
  RxBool jobIsInLoading = true.obs;
  RxBool getSalonsIsInLoading = false.obs;
  final appServices = Get.find<AppServices>();

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  @override
  onInit() {
    super.onInit();
    getJob();
    getNearestSalons();
  }

  updateLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }

  getJob() async {
    try {
      jobIsInLoading.value = true;
      jobs.value = (await ApiServices.getJobs()).jobs ?? [];
      appServices.setJobs(jobs.value);
      jobIsInLoading.value = false;
    } catch (e) {
      jobIsInLoading.value = false;
      print(e);
      if (e is DioException) {
        appSnackBar("error", "Échoué", "${e.response?.data}");
      }
    }
  }

  getNearestSalons() async {
    try {
      getSalonsIsInLoading.value = true;
      await updateLocation();
      GetSalonsData getSalonsData = await ApiServices.getSalons(lat: latitude.value, long: longitude.value);
      nearestSalons.value = getSalonsData.salons ?? [];
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
