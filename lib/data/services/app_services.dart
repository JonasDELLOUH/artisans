import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/core/models/salon_model.dart';
import 'package:artisans/core/models/user_model.dart';
import 'package:artisans/data/data_models/get_user_salon_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/routes/app_routes.dart';
import '../data_models/user_data.dart';
import '../functions/functions.dart';
import 'api_services.dart';
import '../../core/models/job_model.dart';
import 'my_get_storage.dart';

class AppServices extends GetxService {
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  Rxn<SalonModel> currentSalon = Rxn<SalonModel>();
  RxString token = "".obs;
  RxBool hasSalon = false.obs;
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  Future<void> checkLocationPermissionAndFetchLocation() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      // La permission est déjà accordée, obtenez la localisation.
      await updateLocation();
    } else if (status.isDenied) {
      // La permission est refusée, demandez-la à l'utilisateur.
      var result = await Permission.location.request();
      if (result.isGranted) {
        // Permission accordée, obtenez la localisation.
        await updateLocation();
      }
    }
  }

  Future<void> updateLocation() async {
    print("updateLocation");
    try {
      Position position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  setCurrentUser(UserModel userModel, String token1) {
    MyGetStorage.instance.write(Constants.currentUser, userModel.toJson());
    currentUser.value = userModel;
    MyGetStorage.instance.write(Constants.token, token1);
    token.value = token1;
    debugPrint(
        "setCurrentUser \t token : ${MyGetStorage.instance.read("token")}");
  }

  getCurrentUser() {
    currentUser.value =
        UserModel.fromJson(MyGetStorage.instance.read(Constants.currentUser));
    // print("getCurrentUser \t : currentUser : ${currentUser.toJson()}");
    token.value = MyGetStorage.instance.read("token") ?? "";
  }

  setCurrentSalon(SalonModel salonModel) {
    MyGetStorage.instance.write(Constants.currentSalon, salonModel.toJson());
    currentSalon.value = salonModel;
  }

  getCurrentSalon() {
    currentSalon.value =
        SalonModel.fromJson(MyGetStorage.instance.read(Constants.currentSalon));
    if (currentSalon.value != null) {
      hasSalon.value = true;
    }
  }

  setJobs(List<JobModel> jobList) {
    jobs.value = jobList;
  }

  getUserSalon() async {
    try {
      GetUserSalonData getUserSalonData = (await ApiServices.getUserSalon());
      if (getUserSalonData.hasSalon) {
        debugPrint("hasSalonhasSalonhasSalonhasSalon");
        hasSalon.value = true;
        setCurrentSalon(getUserSalonData.salonModel!);
        debugPrint("hasSalon : ${hasSalon.value}");
      }
    } catch (e) {
      debugPrint("$e");
      if (e is DioException) {
        appSnackBar("error", "${e.response?.data}", "}");
      }
    }
  }

  Future<void> handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        debugPrint(
            'Connexion réussie avec Google: ${googleSignInAccount.displayName}');
        bool exist = await ApiServices.verifyUsernameExist(
            username: googleSignInAccount.displayName ?? "");
        if (exist) {
          UserData userData = (await ApiServices.loginUser(
              username: googleSignInAccount.displayName ?? "",
              password: googleSignInAccount.id));
          setCurrentUser(userData.userModel!, userData.token);
          await getUserSalon();
          Get.offAllNamed(AppRoutes.menuRoute);
        } else {
          UserData userData = (await ApiServices.registerUser(
              username: googleSignInAccount.displayName ?? "",
              password: googleSignInAccount.id,
              email: googleSignInAccount.email,
              phoneNumber: ""));
          setCurrentUser(userData.userModel!, userData.token);
          await getUserSalon();
          Get.offAllNamed(AppRoutes.menuRoute);
        }
      } else {
        // L'utilisateur a annulé la connexion.
        debugPrint('Connexion Google annulée.');
      }
    } catch (error) {
      debugPrint("$error");
      if (error is DioException) {
        appSnackBar("error", "failed", "${error.response?.data}");
      }else{
        appSnackBar("error", "failed", "$error");
      }
    }
  }
}

class AppServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppServices());
  }
}
