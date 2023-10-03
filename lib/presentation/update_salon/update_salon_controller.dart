import 'dart:io';
import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/data/data_models/update_salon_data.dart';
import 'package:artisans/data/functions/functions.dart';
import 'package:dio/dio.dart' as dio_;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../core/colors/colors.dart';
import '../../core/functions/map_functions.dart';
import '../../core/models/job_model.dart';
import '../../data/services/app_services.dart';
import '../../data/services/api_services.dart';
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
  TextEditingController whatsappNumberController = TextEditingController();
  TextEditingController descController = TextEditingController();
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
  String initialSalonName = "";
  String initialSalonEmail = "";
  String initialSalonNumber = "";
  String initialSalonWhatsappNumber = "";
  String initialSalonDescription = "";
  File? initialSalonImage;
  double initialLat = 0.0;
  double initialLong = 0.0;

  @override
  void onInit() {
    super.onInit();
    loadSalonData();
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
    dateIsChanged = !(
        initialSalonName == salonNameController.text &&
        initialSalonEmail == emailController.text &&
        initialSalonNumber == telController.text &&
            initialSalonWhatsappNumber == whatsappNumberController.text &&
        initialSalonDescription == descController.text &&
        initialSalonImage?.path == salonImage.value?.path &&
        initialLat == latitude.value &&
        initialLong == longitude.value);
    if (!dateIsChanged) {
      appSnackBar("error", "not_changed_info".tr, "");
    }
    return dateIsChanged;
  }

  loadSalonData() {
    initialSalonName = appServices.currentSalon.value?.salonName ?? "";
    initialSalonEmail = appServices.currentSalon.value?.email ?? "";
    initialSalonNumber = appServices.currentSalon.value?.phone ?? "";
    initialSalonWhatsappNumber = appServices.currentSalon.value?.whatsappNumber ?? "";
    initialSalonDescription = appServices.currentSalon.value?.desc ?? "";
    salonNameController.text = initialSalonName;
    emailController.text = initialSalonEmail;
    telController.text = initialSalonNumber;
    whatsappNumberController.text = initialSalonNumber;
    descController.text = initialSalonDescription;
    if (appServices.currentSalon.value?.imageUrl.isNotEmpty ?? false) {
      downloadAndSetImage();
    }
  }

  Future<void> downloadAndSetImage() async {
    salonImageIsInLoading.value = true;
    try {
      final dio_.Dio dio = dio_.Dio();
      final dio_.Response<List<int>> response = await dio.get<List<int>>(
          Constants.imageOriginUrl +
              (appServices.currentSalon.value?.imageUrl ?? ""),
          options: dio_.Options(responseType: dio_.ResponseType.bytes));

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
            'Échec du téléchargement de l\'image. Code de statut : ${response.statusCode}');
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


  updateSalon() async {
    try {
      String? address = await getAddressFromCoordinates(latitude.value, longitude.value);
      updatingSalon.value = true;
      UpdateSalonData updateSalonData = (await ApiServices.updateSalon(
          name: salonNameController.value.text,
          lat: latitude.value,
          long: longitude.value,
          image: (initialSalonImage?.path == salonImage.value?.path) ? null : salonImage.value!,
          address: address,
          email: emailController.value.text,
          phone: telController.value.text,
          whatsappNumber: whatsappNumberController.value.text,
          desc: descController.value.text,
          salonId: appServices.currentSalon.value?.salonId ?? ""));
      await appServices.setCurrentSalon(updateSalonData.salonModel!);
      updatingSalon.value = false;
      Get.back();
      appSnackBar("success", "salon_updated".tr, "");
      btnController.stop();
    } catch (e) {
      btnController.stop();
      debugPrint("e.response?.data : $e");
      updatingSalon.value = false;
      if (e is DioException) {
        appSnackBar("error", "failed".tr, "${e.response?.data["message"] ?? e.response?.data}");
      }
    }
  }
}
