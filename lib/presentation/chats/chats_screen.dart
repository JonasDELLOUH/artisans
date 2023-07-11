import 'package:artisans/presentation/chats/chats_controller.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key, required this.controller}) : super(key: key);
  ChatsController controller = Get.find<ChatsController>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("ChatsScreen"),),
    );
  }
}
