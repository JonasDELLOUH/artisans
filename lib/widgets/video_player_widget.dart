import 'dart:io';
import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  File file;
  final double width;
  final double height;

  VideoPlayerWidget({super.key, required this.file, this.width = 100.0,
    this.height = 100.0,});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  bool isShowPlaying = false;
  double _currentPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        _videoController.play();
        setState(() {
          isShowPlaying = false;
        });
      });

    _videoController.addListener(() {
      setState(() {
        _currentPosition =
            _videoController.value.position.inMilliseconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Widget isPlaying(){
    return (_videoController.value.isPlaying && !isShowPlaying)  ? Container() : const Icon(Icons.play_arrow,size: 80,color: greyColor,);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _videoController.value.isPlaying
            ? _videoController.pause()
            : _videoController.play();
      },
      child: Column(
        children: [
          _videoController.value.isInitialized
              ? Container(
            height: widget.height,
                width: widget.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(_videoController),
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                        ),
                        child: isPlaying(),
                      ),
                    ),
                    VideoProgressIndicator(
                      _videoController,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: blueColor,
                        bufferedColor: greyColor,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                        right: 5,
                        child: CustomText(text: Duration(milliseconds: _currentPosition.toInt()).toString().split('.')[0], color: blueColor,),)
                  ],
                ),
              )
              : const Center(
                  child: CircularProgressIndicator(color: blueColor)),
          // const SizedBox(height: 10),
          // Text(
          //   Duration(milliseconds: _currentPosition.toInt()).toString().split('.')[0],
          //   style: TextStyle(fontSize: 16),
          // ),
        ],
      ),
    );
  }
}

// class VideoPlayerWidgetController extends GetxController{
//   late VideoPlayerController videoController;
//   RxBool isShowPlaying = false.obs;
//   double currentPosition = 0.0;
//
//   @override
//   void onInit() {
//     super.onInit();
//     videoController = VideoPlayerController.file(widget.file)
//       ..initialize().then((_) {
//         videoController.play();
//           isShowPlaying.value = false;
//
//       });
//   }
// }
