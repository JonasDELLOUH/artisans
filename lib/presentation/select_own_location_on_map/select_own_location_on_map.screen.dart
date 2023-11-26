import 'package:artisans/presentation/select_own_location_on_map/select_own_location_on_map.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/colors/colors.dart';
import '../../widgets/custom_svg_picture.dart';
import '../../widgets/custom_text.dart';

// ignore: must_be_immutable
class SelectOwnLocationOnMapSCreen
    extends GetView<SelectOwnLocationOnMapController> {
  SelectOwnLocationOnMapSCreen({super.key});
  LatLng? selectedlocation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: whiteColor,
              leading: const BackButton(
                color: blueColor,
              ),
              title: const CustomText(text: "Sélectionner une position"),
              actions: [
                IconButton(
                  onPressed: () {
                    controller.switchMapType();
                  },
                  color: blueColor,
                  icon: const Icon(Icons.memory_sharp),
                ),
              ],
            ),
            body: Obx(
              () => Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      mapType: controller.mapType.value,
                      onTap: controller.updateSelectedlocation,
                      onMapCreated: (GoogleMapController controller) {
                        this.controller.mapController = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        zoom: 18.4746,
                        target: controller.selectedlocation.value,
                      ),
                      onCameraMove: controller.handleCameraMove,
                      markers: {
                        Marker(
                          markerId: const MarkerId("curentPosition"),
                          position: controller.selectedlocation.value,
                          consumeTapEvents: true,
                        )
                      },
                    ),
                  ),
                  ListTile(
                      leading: const CustomSvgPicture(
                          width: 40,
                          height: 40,
                          color: blueColor,
                          assetName: "assets/selectedlocation.svg"),
                      title: const CustomText(
                        text: "Envoyer cette localisation",
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: CustomText(
                          fontSize: 12, text: "${controller.locationName} "),
                      onTap: controller.selectLocation),
                ],
              ),
            )));
  }
}
