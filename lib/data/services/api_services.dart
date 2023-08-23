import 'dart:io';
import 'package:artisans/data/data_models/create_salon_data.dart';
import 'package:artisans/data/data_models/get_posts_data.dart';
import 'package:dio/dio.dart' as dio;
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

  static Future<UserData> registerUser({required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required username}) async {
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

  static Future<GetJobsData> getJobs() async {
    var response = await ApiProvider.client.get("job", queryParameters: {});
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is! List) return GetJobsData.fromJson([]);
      return GetJobsData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<CreateSalonData> createSalon({
    required String jobId,
    required String name,
    required double lat,
    required double long,
    required File image,
    required String address,
    required String email,
    required String phone,
    required String desc
  }) async {
    print("createSalon");
    dio.FormData formData = dio.FormData.fromMap({
      "jobId": jobId,
      "name": name,
      "lat": lat,
      "long": long,
      "imageUrl": await dio.MultipartFile.fromFile(image.path),
      "address": address,
      "email": email,
      "phone": phone,
      "desc": desc
    });
    var response = await ApiProvider.client.post("salon", data: formData);
    print("finish");
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is! Map) return CreateSalonData.fromJson({});
      return CreateSalonData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<GetSalonsData> getSalons({String? name, String? jobId, int limit = 10, int skip = 0, double? lat, double? long}) async {
    var response = await ApiProvider.client.get("salon", data: {
      "name": name,
      "jobId": jobId,
      "limit": limit,
      "skip": skip,
      "lat": lat,
      "long": long
    });
    if (response.statusCode == HttpStatus.ok) {
      // if (response.data is! List) return GetSalonsData.fromJson({});
      return GetSalonsData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<GetPostsData> getPosts({int limit = 10, int skip = 0, double? lat, double? long}) async {
    var response = await ApiProvider.client.get("post", data: {
      "limit": limit,
      "skip": skip,
      "lat": lat,
      "long": long
    });
    if (response.statusCode == HttpStatus.ok) {
      // if (response.data is! List) return GetSalonsData.fromJson({});
      return GetPostsData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  static Future<GetStoriesData> getStories({int limit = 10, int skip = 0, double? lat, double? long}) async {
    var response = await ApiProvider.client.get("story", data: {
      "limit": limit,
      "skip": skip,
      "lat": lat,
      "long": long
    });
    if (response.statusCode == HttpStatus.ok) {
      // if (response.data is! List) return GetSalonsData.fromJson({});
      return GetStoriesData.fromJson(response.data);
    } else {
      throw Exception();
    }
  }
}
