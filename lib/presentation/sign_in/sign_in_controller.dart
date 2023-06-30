import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignInController extends GetxController{
  TextEditingController emailController = TextEditingController();
  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();
}