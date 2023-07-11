import 'package:artisans/presentation/profil/profil_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.controller}) : super(key: key);
  ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("ProfileScreen"),),
    );
  }
}
