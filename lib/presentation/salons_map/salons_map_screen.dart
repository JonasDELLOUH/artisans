import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/presentation/salons_map/salons_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SalonsMapScreen extends GetWidget<SalonsMapController> {
  const SalonsMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: (){

          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Obx(() => GoogleMap(
                  myLocationEnabled: true,
                  onMapCreated: (ctrl) => controller.mapController = ctrl,
                  initialCameraPosition: CameraPosition(
                    target: controller.initialPosition.value,
                    zoom: 11.0,
                  ),
                  markers: controller.markers.value,
                )),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 52,
                    padding: const EdgeInsets.only(left: 4, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: blueColor.withOpacity(0.27),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                            blurStyle: BlurStyle.normal,
                          )
                        ]),
                    child:  const Center(
                      child: Row(
                        children: [
                          BackButton(
                            color: blueColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Expanded(
                          //   child: InkWell(
                          //     onTap: () {
                          //     },
                          //     child: SearchTextField(
                          //       suffixIconData: Icons.location_on,
                          //       enabled: false,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
