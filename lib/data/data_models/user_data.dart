import '../../core/models/user_model.dart';

class UserData {
  UserModel? userModel;
  String token = "";

  UserData.fromJson(Map<String, dynamic> json){
    token = json["token"] ?? "";
    userModel = UserModel.fromJson(json["user"]);
  }
}
