import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/core/functions/app_functions.dart';
import 'package:artisans/core/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppServices extends GetxService {
  final box = GetStorage();
  Rxn<UserModel> currentUser = Rxn<UserModel>();

  String _token = "";

  String get token => _token;

  @override
  void onInit() {
    super.onInit();
    _token = getInGetStorage(key: token) ?? "";
  }

  setCurrentUser(){
    currentUser.value = UserModel.fromJson(getInGetStorage(key: Constants.currentUser));
  }

}
