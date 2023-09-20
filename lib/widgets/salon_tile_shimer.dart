import 'package:artisans/widgets/stars_tile.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/colors/colors.dart';
import 'custom_text.dart';

class SalonTileShimmer extends StatelessWidget {
  const SalonTileShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.4),
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                ),
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
                      const CustomText(
                        text: ".........",
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      const CustomText(
                        text: "........",
                        fontSize: 10,
                        color: greyColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: stars(5),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              CustomText(
                                text: ".......",
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
