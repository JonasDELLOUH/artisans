import 'dart:io';
import 'package:artisans/data/data_models/change_password_data.dart';
import 'package:artisans/data/data_models/create_post_data.dart';
import 'package:artisans/data/data_models/create_salon_data.dart';
import 'package:artisans/data/data_models/create_story_data.dart';
import 'package:artisans/data/data_models/get_posts_data.dart';
import 'package:artisans/data/data_models/get_user_salon_data.dart';
import 'package:artisans/data/data_models/update_profile_data.dart';
import 'package:artisans/data/data_models/update_salon_data.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import '../data_models/get_jobs_data.dart';
import '../data_models/get_salons_data.dart';
import '../data_models/get_stories_data.dart';
import '../data_models/user_data.dart';
import '../providers/api_provider.dart';

class ApiServices {
  static Future<UserData> loginUser(
      {required String username, required String password}) async {
    var response = await ApiProvider.client
        .post("auth/login", data: {"username": username, "password": password});
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is! Map) return UserData.fromJson({});
      return UserData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<UserData> registerUser({
    required String email,
    required String phoneNumber,
    required String password,
    required username}) async {
    debugPrint("loginUser");
    var response = await ApiProvider.client.post("auth/register", data: {
      "username": username,
      "email": email,
      "phone_number": phoneNumber,
      "password": password
    });
    debugPrint("finish");
    if (response.statusCode == HttpStatus.created) {
      if (response.data is! Map) return UserData.fromJson({});
      return UserData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<bool> verifyUsernameExist({required String username}) async {
    debugPrint("verifyUsernameExist");
    var response = await ApiProvider.client.post("user/username-exist", data: {
      "username": username,
    });
    debugPrint("finish");
    if (response.statusCode == HttpStatus.ok) {
      return response.data["exist"];
    } else {
      throw Exception();
    }
  }

  static Future<ChangePasswordData> changePassword(
      {required String currentPassword, required String newPassword}) async {
    var response = await ApiProvider.client
        .post("user/change-password",
        data: {"currentPassword": currentPassword, "newPassword": newPassword});
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is! Map) return ChangePasswordData.fromJson({});
      return ChangePasswordData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<UpdateProfileData> updateUserProfile({
    required String email,
    required String phoneNumber,
    required username}) async {
    debugPrint("loginUser");
    var response = await ApiProvider.client.put("user/update-profile", data: {
      "username": username,
      "email": email,
      "phone": phoneNumber,
    });
    debugPrint("finish");
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is! Map) return UpdateProfileData.fromJson({});
      return UpdateProfileData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<GetJobsData> getJobs() async {
    var response = await ApiProvider.client.get("job", queryParameters: {});
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is! List) return GetJobsData.fromJson([]);
      return GetJobsData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<CreateSalonData> createSalon({required String jobId,
    required String name,
    required double lat,
    required double long,
    required File image,
    String? address,
    required String email,
    required String phone,
    required String whatsappNumber,
    required String desc}) async {
    debugPrint("createSalon");
    dio.FormData formData = dio.FormData.fromMap({
      "jobId": jobId,
      "name": name,
      "lat": lat,
      "long": long,
      "imageUrl": await dio.MultipartFile.fromFile(image.path),
      "address": address ?? "",
      "email": email,
      "phone": phone,
      "whatsappNumber": whatsappNumber,
      "desc": desc
    });
    var response = await ApiProvider.client.post("salon", data: formData);
    debugPrint("finish");
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is! Map) return CreateSalonData.fromJson({});
      return CreateSalonData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<UpdateSalonData> updateSalon({
    required String name,
    required double lat,
    required double long,
    File? image,
    String? address,
    required String email,
    required String phone,
    required String whatsappNumber,
    required String desc,
    required String salonId,
  }) async {
    debugPrint("updateSalon: $salonId");

    dio.FormData formData = dio.FormData.fromMap({
      "name": name,
      "lat": lat,
      "long": long,
      "address": address ?? "",
      "email": email,
      "phone": phone,
      "whatsappNumber": whatsappNumber,
      "desc": desc,
    });

    if (image != null) {
      formData.files.add(MapEntry(
        "imageUrl",
        await dio.MultipartFile.fromFile(image.path),
      ));
    }

    var response = await ApiProvider.client.put(
        "salon/$salonId", data: formData);

    debugPrint("finish");

    if (response.statusCode == HttpStatus.ok) {
      if (response.data is! Map) return UpdateSalonData.fromJson({});
      return UpdateSalonData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }


  static Future<GetSalonsData> getSalons({String? name,
    String? jobId,
    int page = 1,
    int perPage = 4,
    double? lat,
    double? long}) async {
    // Démarrez le chrono au début de la requête
    Stopwatch stopwatch = Stopwatch()..start();

    var response = await ApiProvider.client.get("salon", queryParameters: {
      "name": name,
      "jobId": jobId,
      "page": page,
      "per_page": perPage,
      "lat": lat,
      "long": long
    });

    // Arrêtez le chrono après la réception de la réponse
    stopwatch.stop();

    debugPrint('\n \n \n La requête a pris ${stopwatch.elapsedMilliseconds} millisecondes pour s\'exécuter \n \n \n' );


    if (response.statusCode == HttpStatus.ok) {
      // if (response.data is! List) return GetSalonsData.fromJson({});
      return GetSalonsData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<GetPostsData> getPosts({int limit = 10,
    int skip = 0,
    double? lat,
    double? long,
    String? salonId}) async {
    var response = await ApiProvider.client.get("post", queryParameters: {
      "limit": limit,
      "skip": skip,
      "lat": lat,
      "long": long,
      "salonId": salonId
    });
    if (response.statusCode == HttpStatus.ok) {
      // if (response.data is! List) return GetSalonsData.fromJson({});
      return GetPostsData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<CreatePostData> createPost({required String salonId,
    required String content,
    File? image,

  }) async {
    debugPrint("createPost");
    dio.FormData formData = dio.FormData.fromMap({
      "salonId": salonId,
      "content": content,
      "imageUrl": image != null
          ? await dio.MultipartFile.fromFile(image.path)
          : null,
    });
    var response = await ApiProvider.client.post("post", data: formData);
    debugPrint("finish");
    if (response.statusCode == HttpStatus.created) {
      debugPrint("HttpStatus.created");
      if (response.data is! Map) return CreatePostData.fromJson({});
      return CreatePostData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<CreateStoryData> createStory({required String salonId,
    required String content,
    File? video,

  }) async {
    debugPrint("createStory");
    dio.FormData formData = dio.FormData.fromMap({
      "salonId": salonId,
      "content": content,
      "videoUrl": video != null
          ? await dio.MultipartFile.fromFile(video.path)
          : null,
    });
    var response = await ApiProvider.client.post("story", data: formData);
    debugPrint("finish");
    if (response.statusCode == HttpStatus.created) {
      if (response.data is! Map) return CreateStoryData.fromJson({});
      return CreateStoryData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<GetStoriesData> getStories({int limit = 10,
    int skip = 0,
    double? lat,
    double? long,
    String? salonId}) async {
    var response = await ApiProvider.client.get("story", queryParameters: {
      "limit": limit,
      "skip": skip,
      "lat": lat,
      "long": long,
      "salonId": salonId
    });
    if (response.statusCode == HttpStatus.ok) {
      // if (response.data is! List) return GetSalonsData.fromJson({});
      return GetStoriesData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<GetUserSalonData> getUserSalon() async {
    debugPrint("getUserSalon");
    var response = await ApiProvider.client.get("salon/user_salon/");
    debugPrint("finish");
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is! Map) return GetUserSalonData.fromJson({});
      return GetUserSalonData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<bool> verifyLikeStatus({required String salonId}) async {
    debugPrint("verifyLikeStatus");
    var response = await ApiProvider.client.post(
        "salon/verify_like_status/$salonId");
    debugPrint("finish");
    if (response.statusCode == HttpStatus.ok) {
      return response.data["isLiked"];
    } else {
      throw Exception();
    }
  }

  static Future<bool> likeSalon({required String salonId}) async {
    debugPrint("likeSalon");
    var response = await ApiProvider.client.post("salon/like/$salonId");
    debugPrint("finish");
    if (response.statusCode == HttpStatus.ok) {
      return response.data["isLiked"];
    } else {
      throw Exception();
    }
  }

}
