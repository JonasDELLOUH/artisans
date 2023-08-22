import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/utils/app_assets.dart';
import 'package:artisans/widgets/custom_image_asset.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoSalonFindView extends StatelessWidget {
  const NoSalonFindView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImageAsset(
          assetName: AppAssets.salonImage1,
          height: Get.height * 0.3,
          width: Get.width,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomText(
          text: "no_results".tr,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomText(
          text: "no_salon_find".tr,
          fontSize: 15,
          color: greyColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
