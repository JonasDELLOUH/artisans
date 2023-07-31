import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PersonalDataController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController lastPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
}
