import 'dart:typed_data';

import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/core/models/salon_model.dart';
import 'package:artisans/core/models/story_model.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/widgets/custom_image_network.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../core/config/palette.dart';
import 'package:flutter/material.dart';
import '../../../widgets/profile_avatar.dart';
import '../../../widgets/responsive.dart';

class StoryCard extends StatefulWidget {
  final bool isAddStory;
  final SalonModel currentSalon;
  final StoryModel story;

  const StoryCard({
    Key? key,
    this.isAddStory = false,
    required this.currentSalon,
    required this.story,
  }) : super(key: key);

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  String? videoThumbnailUrl;

  @override
  void initState() {
    super.initState();
    if (!widget.isAddStory) {
      getVideoThumbnail();
    }
  }

  Future<Uint8List?> getVideoThumbnail() async {
    final thumbnail = await VideoThumbnail.thumbnailData(
      video: Constants.imageOriginUrl + widget.story.videoUrl,
      imageFormat: ImageFormat.PNG, // Format de l'image (JPEG ou PNG)
      maxWidth: 200, // Largeur maximale de la miniature
      quality: 75, // Qualité de la miniature (0-100)
    );
    return thumbnail;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isAddStory) {
          Get.toNamed(AppRoutes.addPostRoute);
        } else {
          Get.toNamed(AppRoutes.storiesRoute);
        }
      },
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: widget.isAddStory
                  ? CustomImageNetwork(
                      imageUrl: Constants.imageOriginUrl +
                          widget.currentSalon.imageUrl,
                      height: double.infinity,
                      width: 110.0,
                      fit: BoxFit.cover,
                    )
                  : FutureBuilder<Uint8List?>(
                      future: getVideoThumbnail(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return snapshot.data == null
                              ? Container()
                              : Image.memory(snapshot.data!, height: double.infinity,
                            width: 110.0, fit: BoxFit.cover,);
                        } else {
                          return Container(); // Affichez un indicateur de chargement en attendant.
                        }
                      },
                    )),
          Container(
            height: double.infinity,
            width: 110.0,
            decoration: BoxDecoration(
              gradient: Palette.storyGradient,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: Responsive.isDesktop(context)
                  ? const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4.0,
                      ),
                    ]
                  : null,
            ),
          ),
          Positioned(
            top: 8.0,
            left: 8.0,
            child: widget.isAddStory
                ? Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: whiteColor.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add),
                      iconSize: 30.0,
                      color: blueColor,
                      onPressed: () => debugPrint('Add to Story'),
                    ),
                  )
                : ProfileAvatar(
                    imageUrl: Constants.imageOriginUrl +
                        widget.story.salonModel!.imageUrl,
                    hasBorder: true,
                  ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            right: 8.0,
            child: CustomText(
              text: widget.isAddStory
                  ? 'Add to Story'
                  : widget.story.salonModel?.salonName ?? "",
              color: whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
