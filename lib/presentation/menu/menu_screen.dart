import "package:artisans/core/colors/colors.dart";
import "package:artisans/presentation/chats/chats_controller.dart";
import "package:artisans/presentation/chats/chats_screen.dart";
import "package:artisans/presentation/home/home_controller.dart";
import "package:artisans/presentation/home/home_screen.dart";
import "package:artisans/presentation/posts/posts_controller.dart";
import "package:artisans/presentation/posts/posts_screen.dart";
import "package:artisans/presentation/profil/profil_controller.dart";
import "package:artisans/presentation/profil/profile_screen.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../core/constants/icons.dart";
import 'menu_controller.dart' as menu_controller;

class MenuScreen extends GetWidget<menu_controller.MenuController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.currentIndex.value == 0) {
          return true; // Retourne true pour autoriser la sortie de l'application
        } else {
          controller.changePage(0);
          return false; // Retourne false pour bloquer le retour à l'écran précédent
        }
      },
      child: Scaffold(
        body: PageView(
          controller: controller.pageController,
          onPageChanged: controller.changePage,
          children: [
            HomeScreen(controller: Get.put(HomeController())),
            PostsScreen(controller: Get.put(PostsController())),
            ChatsScreen(controller: Get.put(ChatsController())),
            ProfileScreen(controller: Get.put(ProfileController()))
          ],
        ),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: ConstantIcons.homeIcon(),
                  label: "",
                  activeIcon: ConstantIcons.homeIcon(color: violetColor)),
              BottomNavigationBarItem(
                icon: ConstantIcons.postIcon(),
                label: "",
                activeIcon: ConstantIcons.postIcon(color: violetColor),
              ),
              BottomNavigationBarItem(
                icon: ConstantIcons.chatIcon(),
                label: "",
                activeIcon: ConstantIcons.chatIcon(color: violetColor),
              ),
              BottomNavigationBarItem(
                  icon: ConstantIcons.profileIcon(),
                  label: "",
                  activeIcon:
                      ConstantIcons.profileIcon(color: violetColor)),
            ],
          );
        }),
      ),
    );
  }
}
