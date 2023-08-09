import 'package:artisans/core/models/salon_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/constants.dart';
import '../../core/models/job_model.dart';
import '../../core/services/app_services.dart';
import '../../data/api/api_client.dart';
import '../../data/functions/functions.dart';

class HomeController extends GetxController{
  TextEditingController searchController = TextEditingController();
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);
  Rx<List<SalonModel>> nearestSalons = Rx<List<SalonModel>>([]);
  RxBool jobIsInLoading = true.obs;

  @override
  onInit(){
    super.onInit();
    getJob();
  }

  getJob() async {
    final apiClient = ApiClient();
    Map<String, dynamic> parameters = {

    };

    jobIsInLoading.value = true;
    var response = await apiClient.getFromApi(Constants.jobUrl, parameters: parameters);
    jobIsInLoading.value = false;
    if (response["result"] != null) {
      jobs.value = JobModel.fromJsonList(response["result"]);
    } else {
      appSnackBar("error", response["error"], "");
    }
  }

  getSalon() async {
    final apiClient = ApiClient();
    Map<String, dynamic> parameters = {

    };

    jobIsInLoading.value = true;
    var response = await apiClient.getFromApi(Constants.jobUrl, parameters: parameters);
    jobIsInLoading.value = false;
    if (response["result"] != null) {
      jobs.value = JobModel.fromJsonList(response["result"]);
    } else {
      appSnackBar("error", response["error"], "");
    }
  }

}