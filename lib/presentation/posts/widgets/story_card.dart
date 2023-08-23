import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../core/config/palette.dart';
import '../../../core/models/story.dart';
import '../../../core/models/user.dart';
import '../../../core/models/user_model.dart';

import 'package:flutter/material.dart';

import '../../../widgets/profile_avatar.dart';
import '../../../widgets/responsive.dart';
import '../../stories/stories_screen.dart';

class StoryCard extends StatelessWidget {
  final bool isAddStory;
  final User currentUser;
  final Story story;

  const StoryCard({
    Key? key,
    this.isAddStory = false,
    required this.currentUser,
    required this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(isAddStory){
          Get.toNamed(AppRoutes.addPostRoute);
        } else{
          Get.to(const StoriesScreen());
        }
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(
              imageUrl: isAddStory ? currentUser.imageUrl : story.imageUrl,
              height: double.infinity,
              width: 110.0,
              fit: BoxFit.cover,
            ),
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
            child: isAddStory
                ? Container(
                    height: 40.0,
                    width: 40.0,
                    decoration:  BoxDecoration(
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
                    imageUrl: story.user.imageUrl,
                    hasBorder: !story.isViewed,
                  ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            right: 8.0,
            child: CustomText(text:
              isAddStory ? 'Add to Story' : story.user.name,
                color: whiteColor,
                fontWeight: FontWeight.w600,fontSize: 14,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
