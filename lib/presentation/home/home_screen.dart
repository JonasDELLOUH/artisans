import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/widgets/artisan_tile.dart';
import 'package:artisans/core/widgets/custom_icon.dart';
import 'package:artisans/core/widgets/custom_image_network.dart';
import 'package:artisans/core/widgets/custom_text.dart';
import 'package:artisans/core/widgets/search_text_field.dart';
import 'package:artisans/presentation/home/home_controller.dart';
import 'package:artisans/presentation/home/widgets/job_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.controller}) : super(key: key);
  HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomImageNetwork(
                    imageUrl:
                        "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80",
                    height: 30,
                    width: 30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const Row(
                    children: [
                      CustomIcon(
                        icon: Icons.notifications_none,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomIcon(
                        icon: Icons.message,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SearchTextField(
                controller: controller.searchController,
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    JobTile(jobName: "Soudure"),
                      JobTile(jobName: "Coiffure"),
                    JobTile(jobName: "Couture"),
                    JobTile(jobName: "Soudure"),
                    JobTile(jobName: "Soudure"),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: greyColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
height: 180,
                        child: Column(),
                      ),
                    ),
                    Expanded(
                        child: CustomImageNetwork(
                      imageUrl:
                          "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80",
                      borderRadius: BorderRadius.circular(15),
                          height: 200,
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "nearest".tr, fontWeight: FontWeight.w600,),
                  CustomText(text: "view_all".tr, fontSize: 12, color: greyColor,)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  ArtisanTile(salonName: 'Jim Jax', location: '8591 Elgn St. Celina, Delaware', nbrStars: 5, distance: 50,),
                  ArtisanTile(salonName: 'Jim Jax', location: '8591 Elgn St. Celina, Delaware', nbrStars: 5, distance: 50,),
                  ArtisanTile(salonName: 'Jim Jax', location: '8591 Elgn St. Celina, Delaware', nbrStars: 5, distance: 50,),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
