import 'package:artisans/presentation/notifications/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key, required this.controller}) : super(key: key);
  NotificationsController controller = Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("NotificationsScreen"),),
    );
  }
}
