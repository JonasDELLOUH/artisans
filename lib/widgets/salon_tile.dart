import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/functions/app_functions.dart';
import 'package:artisans/core/models/salon_model.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:artisans/widgets/stars_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/constants.dart';
import 'custom_image_network.dart';

class SalonTile extends StatelessWidget {
  SalonTile(
      {Key? key,
      required this.salonModel,
      required this.latitude,
      required this.longitude})
      : super(key: key);
  final SalonModel salonModel;
  final double latitude;
  final double longitude;
  double betweenDistance = 0.0;

  updateDistance() {
    betweenDistance = calculateDistance(
        salonModel.latitude, salonModel.longitude, latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    updateDistance();
    // debugPrint(
    //     "salonModel lat : ${salonModel.latitude}, salonModel long : "
    //         "${salonModel.longitude} \t lat : $latitude, long ${longitude}");
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.salonRoute, arguments: [salonModel]);
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: CustomImageNetwork(
                imageUrl: Constants.imageOriginUrl + salonModel.imageUrl,
                borderRadius: BorderRadius.circular(15),
                height: 80,
                // width: 80,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        text: salonModel.salonName,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      const CustomText(
                        text: "8591 Elgn St. Celina, Delawares",
                        fontSize: 10,
                        color: greyColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: stars(salonModel.nbrStar),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              CustomText(
                                text: betweenDistance >= 1000
                                    ? "${(betweenDistance / 1000).toStringAsFixed(2)} km"
                                    : "${betweenDistance.toStringAsFixed(2)} m",
                                fontSize: 12,
                              )
                            ],
                          )
                        ],
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}
