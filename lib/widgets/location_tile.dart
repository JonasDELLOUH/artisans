import 'package:artisans/core/colors/colors.dart';
import "package:flutter/material.dart";

import '../core/models/locality_model.dart';
import 'custom_svg_picture.dart';
import 'custom_text.dart';

// ignore: must_be_immutable
class LocationTile extends StatelessWidget {
  LocationTile(
      {super.key, required this.onTap, required, required this.localityModel});

  void Function()? onTap;
  final LocalityModel localityModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: greyColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: greyColor)),
        margin: const EdgeInsets.only(top: 10),
        height: 66,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const CustomSvgPicture(assetName: 'assets/location.svg'),
              const SizedBox(width: 16.0),
              Flexible(
                child: CustomText(
                  text: localityModel.description,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
