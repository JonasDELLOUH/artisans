import 'package:artisans/core/models/post_model.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/models/post.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/profile_avatar.dart';

class PostHeader extends StatelessWidget {
  final PostModel postModel;

  const PostHeader({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: Constants.imageOriginUrl + postModel.salonModel!.imageUrl),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: postModel.salonModel!.salonName,
                fontWeight: FontWeight.w600,
              ),
              Row(
                children: [
                  CustomText(
                    text: '${"5h"} • ',
                    fontSize: 12.0,
                    color: greyColor.withOpacity(0.6),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}
