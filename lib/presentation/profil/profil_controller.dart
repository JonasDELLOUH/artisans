import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/constants/constants.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/services/app_services.dart';
import '../../data/services/my_get_storage.dart';

class ProfileController extends GetxController{
  final appServices = Get.find<AppServices>();

  final List<SelectedListItem> listOfLanguages = [
    SelectedListItem(
      name: "english".tr,
      value: "en_US",
      isSelected: false,
    ),
    SelectedListItem(
      name: "french".tr,
      value: "fr_FR",
      isSelected: false,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    print("ProfileController hasSalon : ${appServices.hasSalon.value}");
  }

  logout(){
    MyGetStorage.instance.remove(Constants.currentSalon);
    MyGetStorage.instance.remove(Constants.currentUser);
    MyGetStorage.instance.remove(Constants.token);
    Get.offAllNamed(AppRoutes.signInRoute);
  }



  updateLanguage(String languageCode, String languageCountryCode){
    debugPrint(languageCode);
    debugPrint(languageCountryCode);
    Get.updateLocale(Locale(languageCode, languageCountryCode));

  }

  onTapChangeLanguage(){
    return DropDownState(
      DropDown(
        bottomSheetTitle: CustomText(text:
          "language".tr,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          color: blueColor,
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: listOfLanguages ?? [],
        selectedItems: (List<dynamic> selectedList) {
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              updateLanguage(
                  item.value!.substring(0, 2),
                  item.value!.substring(3, 5));
            }
          }
          // showSnackBar(list.toString());
        },
        enableMultipleSelection: false,
      ),
    ).showModal(Get.context);
  }
}