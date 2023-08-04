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
  RxBool jobIsInLoading = true.obs;

  final appServices = Get.find<AppServices>();

  @override
  onInit(){
    Get.lazyPut(() => AppServices());
    super.onInit();
    signUp();
  }

  signUp() async {
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