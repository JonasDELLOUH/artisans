import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../constants/icons.dart';

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
        height: 30, width: 30,
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
