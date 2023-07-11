import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/widgets/custom_text.dart';
import 'package:artisans/core/widgets/stars_tile.dart';
import 'package:flutter/material.dart';

import 'custom_image_network.dart';

class ArtisanTile extends StatelessWidget {
  ArtisanTile({Key? key, required this.salonName, required this.location, required this.nbrStars, required this.distance}) : super(key: key);
  final String salonName;
  final String location;
  final int nbrStars;
  final double distance;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          CustomImageNetwork(
            imageUrl:
            "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80",
            borderRadius: BorderRadius.circular(15),
            height: 80,
            width: 80,
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(text: salonName, fontWeight: FontWeight.w600, fontSize: 12,),
              CustomText(text: location, fontSize: 10, color: greyColor,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: stars(5),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        CustomText(text: "${distance.toStringAsFixed(1)} km")
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
