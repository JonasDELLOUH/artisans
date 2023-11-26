import 'package:artisans/presentation/select_location/select_location.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/colors/colors.dart';
import '../../core/models/locality_model.dart';
import '../../widgets/custom_svg_picture.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/location_tile.dart';

class SelectLocationScreen extends GetView<SelectLocationController> {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        title: const CustomText(
          text: "Envoyez votre localisation",
          fontWeight: FontWeight.w800,
        ),
        leading: const BackButton(
          color: blueColor,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            return ListView(
              children: [
                ListTile(
                  leading: const CustomSvgPicture(
                    assetName: "assets/currentPosition.svg",
                    color: blueColor,
                  ),
                  title: const CustomText(text: "Envoyer votre position actuelle"),
                  onTap: controller.selectCurrentPosition,
                ),
                ListTile(
                  leading: const CustomSvgPicture(
                    assetName: "assets/map.svg",
                    color: blueColor,
                    height: 18,
                  ),
                  title: const CustomText(text: "Sélectionner sur le map"),
                  trailing: const Icon(
                    Icons.arrow_forward_sharp,
                    color: blueColor,
                  ),
                  onTap: controller.selectFromMap,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                if (controller.noRecentLocality)
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 100),
                    child: CustomText(
                      text: "Vos rechercherches récentes s'afficheront ici",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                  ))
                else
                  for (LocalityModel locality in controller.recentLocalities)
                    LocationTile(
                      onTap: () => controller.selectPosition(locality),
                      localityModel: locality,
                    ),
                if (!controller.noRecentLocality)
                  Center(
                    child: TextButton(
                      onPressed: controller.clearRecentLocalities,
                      child:  const CustomText(text:
                        "Effacer les positions récentes",
                      ),
                    ),
                  ),
              ],
            );
          })
          // controller.isFirstOrder
          //     ? ListView.builder(
          //         itemCount: 6,
          //         itemBuilder: (context, index) {
          //           return LocationTile(
          //             onTap: () => Get.back(result: getPosition(here: true)),
          //             localityModel:
          //                 LocalityModel(localityName: "Localisation $index"),
          //           );
          //           // ListTile(
          //           //   title: Text("Proposition N°$index"),
          //           //   onTap: () => Get.back(result: getPosition(here: true)),
          //           // );
          //         },
          //       )
          //     : Center(
          //         child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //         child: CustomText(
          //           text: "Vos rechercherches récentes s'afficheront ici",
          //           overflow: TextOverflow.visible,
          //           textAlign: TextAlign.center,
          //         ),
          //       )),
          ),
    );
  }
}
