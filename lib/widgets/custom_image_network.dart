import 'package:artisans/core/colors/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final BorderRadiusGeometry? borderRadius;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  CustomImageNetwork({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.low,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.loadingBuilder,
    this.errorBuilder,
    this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(imageUrl:
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        repeat: repeat,
        color: color,
        colorBlendMode: colorBlendMode,
        filterQuality: filterQuality,
        matchTextDirection: matchTextDirection,
      ),
    );
  }
}