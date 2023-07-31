import 'package:artisans/core/colors/colors.dart';
import 'package:flutter/material.dart';

List<Widget> stars(int nbr, {double size = 15}) {
  List<Widget> stars = [];
  for (int i = 0; i < nbr; i++) {
    stars.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        child: Icon(Icons.star, size: size, color: goldenColor,)
    )
    );
  }
  return stars;
}