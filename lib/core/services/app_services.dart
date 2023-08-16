import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/core/models/user_model.dart';
import 'package:get/get.dart';
import '../models/job_model.dart';
import 'my_get_storage.dart';

class AppServices extends GetxService {
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  RxString token = "".obs;
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);

  @override
  void onInit() {
    super.onInit();
  }

  setCurrentUser(UserModel userModel, String token1) {
    MyGetStorage.instance.write(Constants.currentUser, userModel.toJson());
    currentUser.value = userModel;
    MyGetStorage.instance.write(Constants.token, token1);
    token.value = token1;
    print("setCurrentUser \t token : ${MyGetStorage.instance.read("token")}");
  }

  getCurrentUser() {
    currentUser.value =
        UserModel.fromJson(MyGetStorage.instance.read("currentUser"));
    // print("getCurrentUser \t : currentUser : ${currentUser.toJson()}");
    token.value = MyGetStorage.instance.read("token") ?? "";
  }

  setJobs(List<JobModel> jobList){
    jobs.value = jobList;
  }
}
