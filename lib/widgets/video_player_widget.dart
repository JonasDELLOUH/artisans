import 'dart:io';

import 'package:artisans/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final File file;

  const VideoPlayerWidget({super.key, required this.file});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(widget.file)
      ..initialize().then((value) {
        _videoController.play();
        setState(() {
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return _videoController.value.isInitialized
        ? AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          )
        : const Center(child: CircularProgressIndicator(color: blueColor,));
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
