import 'package:artisans/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../core/models/job_model.dart';
import '../../../widgets/custom_image_network.dart';

class JobTile extends StatelessWidget {
  const JobTile({Key? key, required this.jobModel}) : super(key: key);
  final JobModel jobModel;

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Expanded(
            child: CustomImageNetwork(
              imageUrl:
              "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80",
              height: 80, borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(height: 5,),
          CustomText(text: jobModel.jobName, fontSize: 10,)
        ],
      ),
    );
  }
}
