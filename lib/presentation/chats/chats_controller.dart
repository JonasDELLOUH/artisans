import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/services/app_services.dart';
import '../../core/utils/debouncer.dart';
import '../../data/services/firebase_services.dart';

class ChatsController extends GetxController{
  final ScrollController scrollController = ScrollController();

  int limit = 20;
  final int limitIncrement = 20;
  Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  StreamController<bool> buttonClearController = StreamController<bool>();
  TextEditingController searchTextEditingController = TextEditingController();


  final appServices = Get.find<AppServices>();
  RxBool  isLoading = false.obs;
  RxString textSearch = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // setState(() {
      limit += limitIncrement;
      // });
    }
  }

  FirebaseServices firebaseServices =
  FirebaseServices(firebaseFirestore: FirebaseFirestore.instance);
}