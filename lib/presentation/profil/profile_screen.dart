import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/presentation/profil/profil_controller.dart';
import 'package:artisans/presentation/profil/widgets/profile_tile.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:artisans/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.controller}) : super(key: key);
  ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    ProfileAvatar(imageUrl: "https://images.unsplash.com/reserve"
                        "/OlxPGKgRUaX0E1hg3b3X_Dumbo.JPG?ixlib=rb-1.2.1&ixid=eyJhcHB"
                        "faWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
                    SizedBox(width: 7,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "DELLOUH Jonas", fontSize: 12, fontWeight: FontWeight.w700,),
                        CustomText(text: "Design Coiffure", fontSize: 10, color: greyColor,)
                      ],
                    )
                  ],
                ),
              ),
              const Divider(),
              profileTile(iconData: Icons.person_2_outlined, tileName: "personal_data".tr, onTap: (){
                Get.toNamed(AppRoutes.personalDataRoute);
              }),
              profileTile(iconData: Icons.settings, tileName: "settings".tr),
              profileTile(iconData: Icons.password, tileName: "change_password".tr, onTap: (){
                Get.toNamed(AppRoutes.changePasswordRoute);
              }),
              profileTile(iconData: Icons.workspaces_outlined, tileName: "create_salon".tr),
              profileTile(iconData: Icons.logout_outlined, tileName: "logout".tr),
              profileTile(iconData: Icons.work_outline_rounded, tileName: "salon_info".tr),
              const Divider(),
              profileTile(iconData: Icons.privacy_tip_outlined, tileName: "privacy_policy".tr, color: blackColor)
            ],
          ),
        ),
      )),
    );
  }
}
