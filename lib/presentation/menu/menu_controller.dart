import "package:get/get.dart";
import 'package:flutter/material.dart';
class MenuController extends GetxController{
  RxInt currentIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
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