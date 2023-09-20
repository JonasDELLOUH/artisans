import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'custom_text.dart';

class JobTileShimmer extends StatelessWidget {
  const JobTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.4),
      child: Container(
        width: 40,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ), height: 35,
            ),
            const SizedBox(height: 3,),
            const CustomText(text: ".......", fontSize: 9, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2,)
          ],
        ),
      ),
    );
  }
}
