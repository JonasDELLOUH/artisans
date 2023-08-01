import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:artisans/widgets/search_text_field.dart';
import 'package:artisans/presentation/search/widgets/search_job_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/salon_tile.dart';
import '../search/search_controller.dart' as search_controller;

class SearchScreen extends GetView<search_controller.SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: SearchTextField(
                          controller: controller.searchController)),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: (){
                        controller.searchController.clear();
                      },
                      child: const Icon(
                        Icons.clear,
                        size: 30,
                        color: greyColor,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SearchJobTile(jobName: "All",isSelected: true,),
                    SearchJobTile(jobName: "Soudure"),
                    SearchJobTile(jobName: "Coiffure"),
                    SearchJobTile(jobName: "Couture"),
                    SearchJobTile(jobName: "Vulganisateur"),
                    SearchJobTile(jobName: "Mecanique"),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              CustomText(text: "${"result_found".tr}(10)", fontWeight: FontWeight.w700,),
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  physics: ScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index){
                      return SalonTile(
                        salonName: 'Jim Jax',
                        location: '8591 Elgn St. Celina, Delaware',
                        nbrStars: 5,
                        distance: 50,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
