import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchJobTile extends StatelessWidget {
  SearchJobTile({Key? key, required this.jobName, this.isSelected = false})
      : super(key: key);
  final String jobName;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: IntrinsicWidth(
        child: Column(
          children: [
            CustomText(
              text: jobName,
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
    );
  }
}
