import 'dart:io';
import 'package:artisans/widgets/video_player_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../core/colors/colors.dart';

class CustomPictureView extends StatelessWidget {
  final File file;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final bool isVideo;

  const CustomPictureView({
    Key? key,
    required this.file,
    this.width = 100.0,
    this.height = 100.0,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.isVideo = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      color: blueColor,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(12)),
        child: Container(
          width: width,
          height: height,
          child: isVideo
              ? VideoPlayerWidget(file: file)
              : Image.file(
                  file,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
