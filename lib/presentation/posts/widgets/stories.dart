import 'package:artisans/core/models/salon_model.dart';
import 'package:artisans/core/models/story_model.dart';
import 'package:artisans/core/models/user_model.dart';
import 'package:artisans/core/services/app_services.dart';
import 'package:artisans/widgets/responsive.dart';
import 'package:artisans/presentation/posts/widgets/story_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data/data.dart';
import '../../../core/models/story.dart';
import '../../../core/models/user.dart';

class Stories extends StatelessWidget {
  final List<StoryModel> stories;
  final appServices = Get.find<AppServices>();

   Stories({
    Key? key,
    required this.stories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 8.0,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 1 + stories.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Obx(() =>
            appServices.hasSalon.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: StoryCard(
                      isAddStory: true,
                      story: stories[index],
                      currentSalon: appServices.currentSalon.value!,
                    ),
                  )
                : Container());
          }
          final StoryModel story = stories[index - 1];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: StoryCard(
              story: story,
               currentSalon: SalonModel.currentSalon(),
            ),
          );
        },
      ),
    );
  }
}
