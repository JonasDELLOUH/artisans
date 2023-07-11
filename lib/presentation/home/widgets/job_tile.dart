import 'package:artisans/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_image_network.dart';

class JobTile extends StatelessWidget {
  JobTile({Key? key, required this.jobName}) : super(key: key);
  final String jobName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 80,
      child: Column(
        children: [
          CustomImageNetwork(
            imageUrl:
            "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80",
            height: 80, borderRadius: BorderRadius.circular(15),
          ),
          const SizedBox(height: 5,),
          CustomText(text: jobName, fontSize: 10,)
        ],
      ),
    );
  }
}
