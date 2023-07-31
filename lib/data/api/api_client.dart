import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:dio/dio.dart' as Dio;

import '../functions/functions.dart';

class ApiClient extends GetConnect {
  Future<dynamic> getFromApi(url, {Map<String, dynamic>? parameters}) async {
    print("get request : " + url);
    print(parameters.toString());
    try {
      Dio.Dio dio = new Dio.Dio();
      // dio.options.headers = await setHeadersWithToken();
      var response = await dio.get(url, queryParameters: parameters);
      var apiResponse = response.data;
      print("api get response : " + apiResponse.toString());
      return {"result": apiResponse};
    } on Dio.DioError catch (e) {
      var json = e.response.toString();
      print("get response error : " + e.response.toString());
      // errorFormSnackBar(map, jsonDecode(json), e.response?.statusCode);
      print(jsonDecode(json));
      return {
        "result": null,
        "error": jsonDecode(json) == null
            ? " "
            : jsonDecode(json)['message'].toString()
      };
    }
  }

  Future<dynamic> postFromApi(url, dynamic map) async {
    print("post request : " + url);
    print(map.toString());
    try {
      Dio.Dio dio = new Dio.Dio();
      Map<String, dynamic> map2 = await setHeadersWithToken();
      print("voici le token ${map2["Authorization"]}");
      var response = await dio.post(url,
          data: map, options: Dio.Options(headers: map2));
      var apiResponse = response.data;
      print("post response : " + apiResponse.toString());
      // if (apiResponse.containsKey("errors")) {
      //   var errors = apiResponse["errors"];
      //   errors.forEach((k, v) =>
      //       appSnackBar("error", "update_user_failed".tr, v["message"]));
      // }
      return {"result": apiResponse};
    } on Dio.DioError catch (e) {
      var json = e.response.toString();
      print("post response error : " + json);
      // errorFormSnackBar(map, jsonDecode(json), e.response?.statusCode);
      //   print(jsonDecode(json));
      return {
        "result": null,
        "error": json
      };
    }
  }

  Future<dynamic> putFromApi(url, Map<String, dynamic> map) async {
    print("post request : " + url);
    print(map.toString());
    try {
      Dio.Dio dio = new Dio.Dio();
      Map<String, dynamic> map2 = await setHeadersWithToken();
      print("voici le token ${map2["Authorization"]}");
      var response = await dio.put(url,
          data: map, options: Dio.Options(headers: map2));
      var apiResponse = response.data;
      print("post response : " + apiResponse.toString());
      if (apiResponse.containsKey("errors")) {
        var errors = apiResponse["errors"];
        errors.forEach((k, v) =>
            appSnackBar("error", "update_user_failed".tr, v["message"]));
      }
      return {"result": apiResponse};
    } on Dio.DioError catch (e) {
      var json = e.response.toString();
      print("post response error : " + json);
      // errorFormSnackBar(map, jsonDecode(json), e.response?.statusCode);
      //   print(jsonDecode(json));
      return {
        "result": null,
        "error": jsonDecode(json) == null
            ? " "
            : jsonDecode(json)['message'].toString()
      };
    }
  }

  Future<dynamic> patchFromApi(url, Map<String, dynamic> map) async {
    print("post request : " + url);
    print(map.toString());
    try {
      Dio.Dio dio = new Dio.Dio();
      Map<String, dynamic> map2 = await setHeadersWithToken();
      print("voici le token ${map2["Authorization"]}");
      var response = await dio.patch(url,
          data: map, options: Dio.Options(headers: map2));
      var apiResponse = response.data;
      print("post response : " + apiResponse.toString());
      if (apiResponse.containsKey("errors")) {
        var errors = apiResponse["errors"];
        errors.forEach((k, v) =>
            appSnackBar("error", "update_user_failed".tr, v["message"]));
      }
      return {"result": apiResponse};
    } on Dio.DioError catch (e) {
      var json = e.response.toString();
      print("post response error : " + json);
      // errorFormSnackBar(map, jsonDecode(json), e.response?.statusCode);
      //   print(jsonDecode(json));
      return {
        "result": null,
        "error": jsonDecode(json) == null
            ? " "
            : jsonDecode(json)['message'].toString()
      };
    }
  }

  Future<dynamic> postWithFileFromApi(url, Dio.FormData formData) async {
    print("post request : " + url);
    print(formData.fields.lastIndex);
    try {
      Dio.Dio dio = new Dio.Dio();
      Map<String, dynamic> map2 = await setHeadersWithToken();
      print("voici le token ${map2["Authorization"]}");
      var response = await dio.post(url,
          data: formData, options: Dio.Options(headers: map2));
      var apiResponse = response.data;
      print("post response : " + apiResponse.toString());
      return {"result": apiResponse};
    } on Dio.DioError catch (e) {
      var json = e.response.toString();
      print("post response error : " + json);
      // errorFormSnackBar(map, jsonDecode(json), e.response?.statusCode);
      //   print(jsonDecode(json));
      return {
        "result": null,
        "error": jsonDecode(json) == null
            ? " "
            : jsonDecode(json)['message'].toString()
      };
    }
  }
}
