import "package:get/get.dart";
import 'package:flutter/material.dart';

import '../../data/services/app_services.dart';
class MenuController extends GetxController{
  RxInt currentIndex = 0.obs;
  late PageController pageController;
  final appServices = Get.find<AppServices>();

  @override
  void onInit() {
    super.onInit();
    appServices.getCurrentUser();
    appServices.getUserSalon();
    pageController = PageController(initialPage: currentIndex.value);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  changePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(microseconds: 1),
      curve: Curves.ease,
    );
  }
}