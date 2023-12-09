import 'package:artisans/core/models/salon_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/models/job_model.dart';
import '../../core/models/salon_model.dart';
import '../../data/services/app_services.dart';
import '../../data/data_models/get_salons_data.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);
  Rx<List<SalonModel>> nearestSalons = Rx<List<SalonModel>>([]);
  Rxn<SalonModel> starSalon = Rxn<SalonModel>();
  RxBool jobIsInLoading = false.obs;
  RxBool getSalonsIsInLoading = false.obs;
  final appServices = Get.find<AppServices>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  SalonModel s = SalonModel(
      salonId: "6562e09ca6f9912e219c5154",
      jobId: "651c52c10e918d2afcc4ac13",
      salonName: "Cordonnerie Moderne",
      desc: "Ici on remet de la valeur et du design dans vos chaussures !!",
      latitude: 6.596528178491122,
      longitude: 2.3628786206245422,
      imageUrl: "/files/imageUrl-1700978841808-877625775.jpg",
      address: "Atlantique Department, Zinvié",
      nbrStar: 2,
      totalStar: 10,
      email: "jdellouhz@gmail.com",
      phone: "96132525",
      whatsappNumber: "96132525");

  @override
  onInit() {
    starSalon.value = s;
    getJob();
    getNearestSalons();
    super.onInit();
    // debugPrint("HomeController cuurent Salon : ${appServices.currentSalon.toJson()}");
  }

  getJob() async {
    try {
      jobIsInLoading.value = true;
      jobs.value = (await ApiServices.getJobs()).jobs ?? [];
      appServices.setJobs(jobs.value);
      jobIsInLoading.value = false;
    } catch (e) {
      jobIsInLoading.value = false;
      debugPrint("$e");
      if (e is DioException) {
        appSnackBar("error", "Échoué", "${e.response?.data}");
      }
    }
  }

  getNearestSalons() async {
    try {
      getSalonsIsInLoading.value = true;
      await appServices.checkLocationPermissionAndFetchLocation();
      GetSalonsData getSalonsData = await ApiServices.getSalons(
          lat: appServices.latitude.value,
          long: appServices.longitude.value,
          perPage: 4);
      // Arrêtez le chrono après la réception de la réponse
      nearestSalons.value = getSalonsData.salons ?? [];
      getStarSalon();
      getSalonsIsInLoading.value = false;
    } catch (e) {
      getSalonsIsInLoading.value = false;
      debugPrint("$e");
      if (e is DioException) {
        appSnackBar("error", "Échoué", "${e.response?.data}");
      }
    }
  }

  getStarSalon() {
    if (nearestSalons.value.isEmpty) {
      starSalon.value = s;
    } else {
      starSalon.value = nearestSalons.value.first;
      for (SalonModel salon in nearestSalons.value) {
        if (salon.nbrStar > starSalon.value!.totalStar) {
          starSalon.value = salon;
        }
      }
    }
  }
}
