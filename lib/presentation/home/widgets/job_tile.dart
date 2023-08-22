import 'package:artisans/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/job_model.dart';
import '../../../widgets/custom_image_network.dart';

class JobTile extends StatelessWidget {
  JobTile({Key? key, required this.jobModel, this.onTap}) : super(key: key);
  final JobModel jobModel;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            CustomImageNetwork(
              imageUrl: Constants.imageOriginUrl + jobModel.jobImageUrl,
               borderRadius: BorderRadius.circular(10), height: 35,
            ),
            const SizedBox(height: 5,),
            CustomText(text: jobModel.jobName, fontSize: 9, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2,)
          ],
        ),
      ),
    );
  }
}
