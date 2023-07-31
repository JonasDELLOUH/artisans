import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/models/post_model.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/profile_avatar.dart';

class PostHeader extends StatelessWidget {
  final Post post;

  const PostHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user.imageUrl),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: post.user.name,
                fontWeight: FontWeight.w600,
              ),
              Row(
                children: [
                  CustomText(
                    text: '${post.timeAgo} • ',
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
