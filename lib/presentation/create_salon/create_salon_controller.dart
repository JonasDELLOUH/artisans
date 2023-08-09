import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

import '../../core/constants/constants.dart';
import '../../core/models/job_model.dart';
import '../../data/api/api_client.dart';
import '../../data/functions/functions.dart';

class CreateSalonController extends GetxController {
  Rx<List<SelectedListItem>> selectedListItems = Rx<List<SelectedListItem>>([]);
  Rxn<SelectedListItem> itemSelected = Rxn<SelectedListItem>();
  TextEditingController salonNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telController = TextEditingController();
  RxInt stepIndex = 1.obs;
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);
  RxBool jobIsInLoading = true.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  final formKey = GlobalKey<FormState>();

  Rx<StaticMapController> locationController = Rx<StaticMapController>(
      const StaticMapController(
          googleApiKey: "AIzaSyDxqb7_tC61JYB3YWv5MY9JlNECUIJIUDQ",
          width: 300,
          height: 264,
          center: Location(0.0, 0.0),
          zoom: 10));

  @override
  void onInit() {
    super.onInit();
    updateLocation();
    itemSelected.value = SelectedListItem(name: "Autre");
    getJob();
  }

  updateLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    print("longitude : $longitude");
    locationController.value = StaticMapController(
        googleApiKey: "AIzaSyDxqb7_tC61JYB3YWv5MY9JlNECUIJIUDQ",
        width: (Get.width * 0.7).toInt(),
        height: 264,
        center: Location(latitude.value, longitude.value),
        zoom: 10);
  }

  bool? step1IsOk() {
    return (formKey.currentState?.validate());
  }

  bool step3IsOk() {
    return true;
  }

  getJobInItem() {
    for (JobModel jobModel in jobs.value) {
      SelectedListItem selectedListItem =
          SelectedListItem(name: jobModel.jobName, value: jobModel.jobId);
      selectedListItems.value.add(selectedListItem);
    }
  }

  getJob() async {
    final apiClient = ApiClient();
    Map<String, dynamic> parameters = {};

    jobIsInLoading.value = true;
    var response =
        await apiClient.getFromApi(Constants.jobUrl, parameters: parameters);
    jobIsInLoading.value = false;
    if (response["result"] != null) {
      jobs.value = JobModel.fromJsonList(response["result"]);
    } else {
      appSnackBar("error", response["error"], "");
    }
    getJobInItem();
  }
}
