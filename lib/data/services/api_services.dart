import 'dart:io';

import '../data_models/user_data.dart';
import '../providers/api_provider.dart';

class ApiServices {
  static Future<UserData> loginUser(
      {required String username, required String password}) async {
    var response = await ApiProvider.client.post("login",
        data: {"username": username, "password": password});
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is! Map) return UserData.fromJson({});
      return UserData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<UserData> registerUser(
      {required String name,
      required String email,
      required int phoneNumber,
      required String password}) async {
    print("loginUser");
    var response = await ApiProvider.client.post("register", data: {
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "password": password
    });
    print("finish");
    if (response.statusCode == HttpStatus.created) {
      if (response.data is! Map) return UserData.fromJson({});
      return UserData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<UserData> createSalon(
      {required String name,
        required String email,
        required int phoneNumber,
        required String password,
        required double long,
        required double lat,
        required String jonId,

      }) async {
    print("loginUser");
    var response = await ApiProvider.client.post("register", data: {
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "password": password
    });
    print("finish");
    if (response.statusCode == HttpStatus.created) {
      if (response.data is! Map) return UserData.fromJson({});
      return UserData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }
}
