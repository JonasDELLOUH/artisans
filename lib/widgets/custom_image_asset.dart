import 'package:flutter/material.dart';

class CustomImageAsset extends StatelessWidget {
  final String assetName;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;
  final BlendMode? colorBlendMode;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  const CustomImageAsset({
    Key? key,
    required this.assetName,
    this.width = 100.0,
    this.height = 100.0,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlendMode,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: shape,
          color: color,
          image: DecorationImage(
            image: AssetImage(assetName),
            fit: fit,
            colorFilter: colorBlendMode != null
                ? ColorFilter.mode(color ?? Colors.transparent, colorBlendMode!)
                : null,
          ),
        ),
        child: SizedBox(
          width: width,
          height: height,
        ),
      ),
    );
  }
}
