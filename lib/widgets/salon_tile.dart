import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/models/salon_model.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:artisans/widgets/stars_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/constants.dart';
import 'custom_image_network.dart';

class SalonTile extends StatelessWidget {
  SalonTile({Key? key, required this.salonModel}) : super(key: key);
  final SalonModel salonModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(AppRoutes.salonRoute);
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            CustomImageNetwork(
              imageUrl: Constants.imageOriginUrl + salonModel.imageUrl,
              borderRadius: BorderRadius.circular(15),
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(text: salonModel.salonName, fontWeight: FontWeight.w600, fontSize: 12,),
                const CustomText(text: "8591 Elgn St. Celina, Delaware", fontSize: 10, color: greyColor,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: stars(5),
                    ),
                    Container(
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          CustomText(text: "${50.toStringAsFixed(1)} km")
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

