import 'dart:io';
import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/data/data_models/create_salon_data.dart';
import 'package:artisans/secret.dart';
import 'package:dio/dio.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../core/models/job_model.dart';
import '../../core/services/app_services.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';
import '../../widgets/custom_text.dart';

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
  RxBool creatingSalon = false.obs;
  final formKey = GlobalKey<FormState>();

  Rxn<File> salonImage = Rxn<File>();
  final appServices = Get.find<AppServices>();
  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();

  Rx<StaticMapController> locationController = Rx<StaticMapController>(
      const StaticMapController(
          googleApiKey: Secret.googleApiKey,
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

  createSalon() async {
    try {
      creatingSalon.value = true;
      CreateSalonData createSalonData = (await ApiServices.createSalon(
        jobId: itemSelected.value?.value ?? "",
        name: salonNameController.value.text,
        lat: latitude.value,
        long: longitude.value,
        image: salonImage.value!,
        address: "",
        email: emailController.value.text,
        phone: telController.value.text,
      ));
      creatingSalon.value = false;
      Get.back();
      appSnackBar("success", "salon_created".tr, "");
      btnController.stop();
    } catch (e) {
      btnController.stop();
      print("e.response?.data : $e");
      creatingSalon.value = false;
      if (e is DioException) {
        appSnackBar("error", "failed".tr, "${e.response?.data}");
      }
    }
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

  imgFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? image =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    dynamic files = [];
    files.add(File(image!.path));
    salonImage.value = File(image.path);
  }

  imgFromGallery() async {
    final ImagePicker _picker = ImagePicker();

    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    dynamic files = [];
    files.add(File(image!.path));
    salonImage.value = File(image.path);
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

  bool? step1IsOk() {
    return (formKey.currentState?.validate());
  }

  bool step3IsOk() {
    return salonImage.value != null;
  }

  getJobInItem() {
    for (JobModel jobModel in jobs.value) {
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
