import 'dart:io';

import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/colors/colors.dart';
import '../../core/models/job_model.dart';
import '../../core/services/app_services.dart';
import '../../secret.dart';
import '../../widgets/custom_text.dart';

class UpdateSalonController extends GetxController{
  Rx<StaticMapController> locationController = Rx<StaticMapController>(
       const StaticMapController(
          googleApiKey: Secret.googleApiKey,
          width: 300,
          height: 264,
          center: Location(0.0, 0.0),
          zoom: 10));
  TextEditingController salonNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Rx<List<SelectedListItem>> selectedListItems = Rx<List<SelectedListItem>>([]);
  Rxn<SelectedListItem> itemSelected = Rxn<SelectedListItem>();

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();
  Rxn<File> salonImage = Rxn<File>();
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);
  final appServices = Get.find<AppServices>();


  @override
  void onInit() {
    super.onInit();
    updateLocation();
    loadSalonData();
    getJob();
    updateLocation();
  }

  loadSalonData(){
    salonNameController.text = appServices.currentSalon.value?.salonName ?? "";
    emailController.text = appServices.currentSalon.value?.email ?? "";
    telController.text = appServices.currentSalon.value?.phone ?? "";
    descController.text = appServices.currentSalon.value?.desc ?? "";
  }

  imgFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? image =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    dynamic files = [];
    files.add(File(image!.path));
    salonImage.value = File(image.path);
  }

  imgFromGallery() async {
    final ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    dynamic files = [];
    files.add(File(image!.path));
    salonImage.value = File(image.path);
  }

  updateLocation() async {
    var permissionStatus = await Permission.location.request();
    Position position = await Geolocator.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    locationController.value = StaticMapController(
        googleApiKey: Secret.googleApiKey,
        width: (Get.width * 0.7).toInt(),
        height: 264,
        center: Location(latitude.value, longitude.value),
        zoom: 10);
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                      color: blueColor,
                    ),
                    title: const CustomText(
                      text: "Galery",
                    ),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera, color: blueColor),
                  title: const CustomText(text: "Camera"),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  getJobInItem() {
    for (JobModel jobModel in jobs.value) {
      if(jobModel.jobId == appServices.currentSalon.value?.jobId){
        itemSelected.value = SelectedListItem(name: jobModel.jobName, value: jobModel.jobId);
      }
      SelectedListItem selectedListItem =
      SelectedListItem(name: jobModel.jobName, value: jobModel.jobId);
      selectedListItems.value.add(selectedListItem);
    }
  }

  getJob() async {
    jobs.value = appServices.jobs.value;
    getJobInItem();
  }
}