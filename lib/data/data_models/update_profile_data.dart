import '../../core/models/user_model.dart';

class UpdateProfileData {
  UserModel? userModel;
  String? message;

  UpdateProfileData.fromJson(Map<String, dynamic> json){
    if(json["updatedUser"] != null) {
      userModel = UserModel.fromJson(json["updatedUser"]);
    }
    message = json["message"] ?? "";
  }
}