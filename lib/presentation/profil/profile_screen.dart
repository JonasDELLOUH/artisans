import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/core/utils/custom_show_dialog.dart';
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Obx(() => controller.appServices.hasSalon.value
                        ? ProfileAvatar(
                            imageUrl: Constants.imageOriginUrl +
                                (controller.appServices.currentSalon.value
                                        ?.imageUrl ??
                                    ""),
                          )
                        : CircleAvatar(
                            radius: 20.0,
                            backgroundColor: blueColor,
                            child: CustomText(
                              text: (controller
                                      .appServices.currentUser.value?.username
                                      .substring(0, 1)
                                      .toUpperCase()) ??
                                  "",
                              color: whiteColor,
                            ),
                          )),
                    const SizedBox(
                      width: 7,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => CustomText(
                              text: controller.appServices.currentUser.value
                                      ?.username ??
                                  "",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            )),
                        Obx(() => controller.appServices.hasSalon.value
                            ? CustomText(
                                text: controller.appServices.currentSalon.value
                                        ?.salonName ??
                                    "",
                                fontSize: 10,
                                color: greyColor,
                              )
                            : Container())
                      ],
                    )
                  ],
                ),
              ),
              const Divider(),
              profileTile(
                  iconData: Icons.person_2_outlined,
                  tileName: "personal_data".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.personalDataRoute);
                  }),
              profileTile(iconData: Icons.settings, tileName: "settings".tr),
              profileTile(
                  iconData: Icons.password,
                  tileName: "change_password".tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.changePasswordRoute);
                  }),
              Obx(() => controller.appServices.hasSalon.value == false
                  ? profileTile(
                      iconData: Icons.workspaces_outlined,
                      tileName: "create_salon".tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.createSalonRoute);
                      })
                  : Container()),

              Obx(() => controller.appServices.hasSalon.value
                  ? profileTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.updateSalonRoute);
                      },
                      iconData: Icons.work_outline_rounded,
                      tileName: "salon_info".tr)
                  : Container()),
              profileTile(
                  onTap: () {
                    customShowDialog(
                        context: context,
                        dialogTitle: "logout".tr,
                        dialogDesc: 'ask_logout'.tr,
                        onOkay: () {
                          controller.logout();
                        });
                  },
                  iconData: Icons.logout_outlined,
                  tileName: "logout".tr),
              const Divider(),
              profileTile(
                  iconData: Icons.privacy_tip_outlined,
                  tileName: "privacy_policy".tr,
                  color: blackColor)
            ],
          ),
        ),
      )),
    );
  }
}
