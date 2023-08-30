import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/core/models/salon_model.dart';
import 'package:artisans/core/models/user_model.dart';
import 'package:artisans/data/data_models/get_user_salon_data.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../data/functions/functions.dart';
import '../../data/services/api_services.dart';
import '../models/job_model.dart';
import 'my_get_storage.dart';

class AppServices extends GetxService {
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  Rxn<SalonModel> currentSalon = Rxn<SalonModel>();
  RxString token = "".obs;
  RxBool hasSalon = false.obs;
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);

  setCurrentUser(UserModel userModel, String token1) {
    MyGetStorage.instance.write(Constants.currentUser, userModel.toJson());
    currentUser.value = userModel;
    MyGetStorage.instance.write(Constants.token, token1);
    token.value = token1;
    print("setCurrentUser \t token : ${MyGetStorage.instance.read("token")}");
  }
  getCurrentUser() {
    currentUser.value =
        UserModel.fromJson(MyGetStorage.instance.read(Constants.currentUser));
    // print("getCurrentUser \t : currentUser : ${currentUser.toJson()}");
    token.value = MyGetStorage.instance.read("token") ?? "";
  }

  setCurrentSalon(SalonModel salonModel){
    MyGetStorage.instance.write(Constants.currentSalon, salonModel.toJson());
    currentSalon.value = salonModel;
  }

  getCurrentSalon(){
    currentSalon.value = SalonModel.fromJson(MyGetStorage.instance.read(Constants.currentSalon));
    if(currentSalon.value != null){
      hasSalon.value = true;
    }
  }

  setJobs(List<JobModel> jobList){
    jobs.value = jobList;
  }

  getUserSalon() async {
    try {
      GetUserSalonData getUserSalonData = (await ApiServices.getUserSalon());
      if(getUserSalonData.hasSalon){
        print("hasSalonhasSalonhasSalonhasSalon");
        hasSalon.value = true;
        setCurrentSalon(getUserSalonData.salonModel!);
        print("hasSalon : ${hasSalon.value}");
      }
    } catch (e) {
      print(e);
      if (e is DioException) {
        appSnackBar("error", "${e.response?.data}",
            "}");
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

