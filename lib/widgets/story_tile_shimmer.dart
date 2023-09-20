import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoryTileShimmer extends StatelessWidget {
  const StoryTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.4),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 200,
        width: 110.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0)
        ),
      ),
    );
  }
}
