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
  final BorderRadiusGeometry borderRadius;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  Widget Function(BuildContext, String, dynamic)? errorWidget;

  CustomImageNetwork({Key? key,
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
    this.borderRadius = BorderRadius.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        repeat: repeat,
        color: color,
        colorBlendMode: colorBlendMode,
        filterQuality: filterQuality,
        matchTextDirection: matchTextDirection,
        errorWidget:
        errorWidget ?? (context, url, error){
          debugPrint("cached netword image error : ${error.toString()} \n l'url : $url");
          return const Icon(Icons.error);
        },
        placeholder: (context, url) =>
            Container(color: greyColor.withOpacity(0.1),),
        // progressIndicatorBuilder: (context, url, downloadProgress) =>
        //     CircularProgressIndicator(value: downloadProgress.progress),
      ),
    );
  }
}
