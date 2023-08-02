import 'package:artisans/core/colors/colors.dart';
import 'package:flutter/material.dart';

Widget takeTofEmptyView({required String text}){
  return Container(
    height: 155,
    decoration: BoxDecoration(
      border: Border.all(color: blueColor)
    ),
  );
}