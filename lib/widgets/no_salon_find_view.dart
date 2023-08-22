import 'package:artisans/core/utils/app_assets.dart';
import 'package:artisans/widgets/custom_image_asset.dart';
import 'package:flutter/material.dart';

class NoSalonFindView extends StatelessWidget {
  const NoSalonFindView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageAsset(assetName: AppAssets.salonImage1)
          ],
        ),
      ),
    );
  }
}
