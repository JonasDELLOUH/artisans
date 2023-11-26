import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgPicture extends StatelessWidget {
  final String assetName;
  final Color? color;
  final double width;
  final double height;
  final BoxFit fit;

  const CustomSvgPicture({
    Key? key,
    required this.assetName,
    this.color,
    this.width = 24.0,
    this.height = 24.0,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      color: color,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
