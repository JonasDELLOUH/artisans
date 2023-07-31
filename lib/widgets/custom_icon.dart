import 'package:flutter/material.dart';

import '../core/colors/colors.dart';


class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key, this.icon, this.iconSize = 20, this.iconColor}) : super(key: key);
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: iconSize! * 1.5, width: iconSize! * 1.5,
        decoration: BoxDecoration(
            border: Border.all(color: greyColor)
        ),
        child: Center(
          child: Icon(icon, size: iconSize, color: iconColor,),
        ),
      ),
    );
  }
}
