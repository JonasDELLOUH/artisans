import '../../core/models/user_model.dart';

class UserData {
  UserModel? userModel;

  UserData.fromJson(Map<String, dynamic> json){
    userModel = UserModel.fromJson(json);
  }
}
