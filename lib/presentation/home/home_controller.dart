import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/models/job_model.dart';

class HomeController extends GetxController{
  TextEditingController searchController = TextEditingController();
  Rx<List<JobModel>> jobs = Rx<List<JobModel>>([]);
}