import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController{
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 1), () async {
      print("hdhdh");
    });
  }
}