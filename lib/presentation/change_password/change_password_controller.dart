import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ChangePasswordController extends GetxController{
  TextEditingController lastPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();
}