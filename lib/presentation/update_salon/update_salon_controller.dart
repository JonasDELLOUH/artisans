import 'dart:io';
import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/data/functions/functions.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:dio/dio.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../core/colors/colors.dart';
import '../../core/models/job_model.dart';
import '../../core/services/app_services.dart';
import '../../secret.dart';
import '../../widgets/custom_text.dart';

class UpdateSalonController extends GetxController {
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
  RxBool salonImageIsInLoading = true.obs;
  final formKey = GlobalKey<FormState>();

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();
  Rxn<File> salonImage = Rxn<File>();
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);
  final appServices = Get.find<AppServices>();
  RxBool updatingSalon = false.obs;

  String initialJobId = "";
  String initialSalonName = "";
  String initialSalonEmail = "";
  String initialSalonNumber = "";
  String initialSalonDescription = "";
  File? initialSalonImage;
  double initialLat = 0.0;
  double initialLong = 0.0;


  @override
  void onInit() {
    super.onInit();
    loadSalonData();
    getJob();
    updateLocation();
  }

  bool canUpdate() {
    if (formKey.currentState?.validate() ?? false) {
      return dateIsChanged();
    }
    return false;
  }

  bool dateIsChanged() {
    bool dateIsChanged = false;
    dateIsChanged = !(initialJobId == itemSelected.value?.value
        && initialSalonName == initialSalonName &&
        initialSalonEmail == telController.text &&
        initialSalonNumber == initialSalonNumber &&
        initialSalonDescription == initialSalonDescription &&
        initialSalonImage?.path == salonImage.value?.path &&
        initialLat == latitude.value &&
        initialLong == longitude.value
    );
    if(!dateIsChanged){
      appSnackBar("error", "not_changed_info".tr, "");
    }
    return dateIsChanged;
  }

  loadSalonData() {
    initialSalonName = appServices.currentSalon.value?.salonName ?? "";
    initialSalonEmail = appServices.currentSalon.value?.email ?? "";
    initialSalonNumber = appServices.currentSalon.value?.phone ?? "";
    initialSalonDescription = appServices.currentSalon.value?.desc ?? "";

    salonNameController.text = initialSalonName;
    emailController.text = initialSalonEmail;
    telController.text = initialSalonNumber;
    descController.text = initialSalonDescription;
    if (appServices.currentSalon.value?.imageUrl.isNotEmpty ?? false) {
      downloadAndSetImage();
    }
  }

  Future<void> downloadAndSetImage() async {
    salonImageIsInLoading.value = true;
    try {
      final dioo.Dio dio = dioo.Dio();
      final dioo.Response<List<int>> response = await dio.get<List<int>>(
          Constants.imageOriginUrl +
              (appServices.currentSalon.value?.imageUrl ?? ""),
          options: dioo.Options(responseType: dioo.ResponseType.bytes));

      if (response.statusCode == 200) {
        final List<int> imageData = response.data!;

        // Obtenez le répertoire temporaire de l'application
        final Directory tempDir = await getTemporaryDirectory();

        // Créez un fichier temporaire dans le répertoire temporaire
        final File tempImage = File('${tempDir.path}/votre-image.jpg');

        await tempImage.writeAsBytes(imageData);
        // Mettez à jour salonImage avec le fichier temporaire
        salonImage.value = tempImage;
        initialSalonImage = salonImage.value;
        salonImageIsInLoading.value = false;
      } else {
        debugPrint(
            'Échec du téléchargement de l\'image. Code de statut : ${response
                .statusCode}');
      }
    } catch (e) {
      debugPrint('Erreur lors du téléchargement de l\'image : $e');
      salonImageIsInLoading.value = false;
    }
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
    initialLat = appServices.currentSalon.value?.latitude ?? 0;
    initialLong = appServices.currentSalon.value?.longitude ?? 0;

    latitude.value = initialLat;
    longitude.value = initialLong;
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
      if (jobModel.jobId == appServices.currentSalon.value?.jobId) {
        itemSelected.value =
            SelectedListItem(name: jobModel.jobName, value: jobModel.jobId);
        initialJobId = jobModel.jobId;
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

  updateSalon() async {
    try {
      updatingSalon.value = true;
      CreateSalonData createSalonData = (await ApiServices.createSalon(
          jobId: itemSelected.value?.value ?? "",
          name: salonNameController.value.text,
          lat: latitude.value,
          long: longitude.value,
          image: salonImage.value!,
          address: "",
          email: emailController.value.text,
          phone: telController.value.text,
          desc: descController.value.text));
      await appServices.getUserSalon();
      updatingSalon.value = false;
      Get.back();
      appSnackBar("success", "salon_created".tr, "");
      btnController.stop();
    } catch (e) {
      btnController.stop();
      debugPrint("e.response?.data : $e");
      updatingSalon.value = false;
      if (e is DioException) {
        appSnackBar("error", "failed".tr, "${e.response?.data}");
      }
    }
  }
}