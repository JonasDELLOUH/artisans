import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/presentation/stories/stories_controller.dart';
import 'package:artisans/presentation/stories/widgets/left_panel.dart';
import 'package:artisans/presentation/stories/widgets/right_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../core/models/salon_model.dart';
import '../../core/routes/app_routes.dart';

class StoriesScreen extends GetView<StoriesController> {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => controller.storyIsInLoading.value
            ? const Center(child: CircularProgressIndicator())
            : getBody()));
  }

  Widget getBody() {
    return RotatedBox(
      quarterTurns: 1,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.stories.value.length,
          itemBuilder: (context, index) {
            return VideoPlayerItem(
              salonModel: controller.stories.value[index].salonModel ?? SalonModel.currentSalon(),
              videoUrl: Constants.imageOriginUrl +
                  controller.stories.value[index].videoUrl,
              size: Get.size,
              name: controller.stories.value[index].salonModel?.salonName ?? "",
              caption: controller.stories.value[index].content,
              songName: "",
              profileImg: Constants.imageOriginUrl +
                  controller.stories.value[index].salonModel!.imageUrl,
              likes: "items[index]['likes']",
              comments: "items[index]['comments']",
              shares: "items[index]['shares']",
              albumImg: "",
            );
          }),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String name;
  final String caption;
  final String songName;
  final String profileImg;
  final String likes;
  final String comments;
  final String shares;
  final String albumImg;
  final SalonModel salonModel;

  VideoPlayerItem(
      {Key? key,
      required this.size,
      required this.name,
      required this.caption,
      required this.songName,
      required this.profileImg,
      required this.likes,
      required this.comments,
      required this.shares,
      required this.albumImg,
      required this.videoUrl, required this.salonModel})
      : super(key: key);

  final Size size;

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _videoController;
  bool isShowPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Voici l'url de la video : ${widget.videoUrl}");

    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((value) {
            _videoController.play();
            setState(() {
              isShowPlaying = false;
            });
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoController.dispose();
  }

  Widget isPlaying() {
    return _videoController.value.isPlaying && !isShowPlaying
        ? Container()
        : Icon(
            Icons.play_arrow,
            size: 80,
            color: Colors.white.withOpacity(0.5),
          );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play();
        });
      },
      child: RotatedBox(
        quarterTurns: -1,
        child: SizedBox(
            height: widget.size.height,
            width: widget.size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  height: widget.size.height,
                  width: widget.size.width,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Stack(
                    children: <Widget>[
                      VideoPlayer(_videoController),
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: isPlaying(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: widget.size.height,
                  width: widget.size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 20, bottom: 10),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // HeaderHomePage(),
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              LeftPanel(
                                size: widget.size,
                                name: widget.name,
                                caption: widget.caption,
                                songName: widget.songName,
                              ),
                              RightPanel(
                                salonModel: widget.salonModel,
                                size: widget.size,
                                likes: widget.likes,
                                comments: widget.comments,
                                shares: widget.shares,
                                profileImg: widget.profileImg,
                                albumImg: widget.albumImg,
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
