import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/core/models/salon_model.dart';
import 'package:artisans/core/models/story_model.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/widgets/custom_image_network.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../core/config/palette.dart';
import '../../../core/models/story.dart';
import '../../../core/models/user.dart';
import '../../../core/models/user_model.dart';

import 'package:flutter/material.dart';

import '../../../widgets/profile_avatar.dart';
import '../../../widgets/responsive.dart';
import '../../stories/stories_screen.dart';

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
  late PageController _pageController;
  List<String> videoThumbnailUrls = [];

  @override
  void initState() {
    super.initState();
    _loadVideoThumbnails();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadVideoThumbnails() async {
    final thumbnails = await VideoThumbnail.thumbnailFile(
      video: Constants.imageOriginUrl + widget.story.videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 25,
    );

    setState(() {
      videoThumbnailUrls
          .add(thumbnails!); // Ajouter l'URL de la miniature à la liste
    });
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
                    imageUrl: Constants.imageOriginUrl + widget.currentSalon.imageUrl,
                    height: double.infinity,
                    width: 110.0,
                    fit: BoxFit.cover,
                  )
                : Container()
            // PageView.builder(
            //         controller: _pageController,
            //         itemCount: videoThumbnailUrls.length,
            //         itemBuilder: (context, index) {
            //           return ClipRRect(
            //             borderRadius: BorderRadius.circular(12.0),
            //             child: CachedNetworkImage(
            //               imageUrl: videoThumbnailUrls[index],
            //               height: double.infinity,
            //               width: 110.0,
            //               fit: BoxFit.cover,
            //             ),
            //           );
            //         },
            //       ),
          ),
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
                      onPressed: () => print('Add to Story'),
                    ),
                  )
                : ProfileAvatar(
                    imageUrl: Constants.imageOriginUrl + widget.story.salonModel!.imageUrl ,
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
