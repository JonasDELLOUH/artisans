import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/models/job_model.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchJobTile extends StatelessWidget {
  SearchJobTile({Key? key,this.isSelected = false, required this.jobModel, this.onTap})
      : super(key: key);
  final JobModel jobModel;
  bool isSelected;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: IntrinsicWidth(
          child: Column(
            children: [
              CustomText(
                text: jobModel.jobName,
                color: isSelected ? blackColor : greyColor,
              ),
              const SizedBox(
                height: 5,
              ),
              isSelected
                  ? Container(
                  height: 2,
                  color: blueColor,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
