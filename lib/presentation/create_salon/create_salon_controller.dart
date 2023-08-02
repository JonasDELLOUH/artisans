import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_static_maps_controller/google_static_maps_controller.dart';

class CreateSalonController extends GetxController {
  Rx<List<SelectedListItem>> selectedListItems = Rx<List<SelectedListItem>>([]);
  Rxn<SelectedListItem> itemSelected = Rxn<SelectedListItem>();
  TextEditingController salonNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telController = TextEditingController();
  RxInt stepIndex = 1.obs;
  final locationController = const StaticMapController(
      googleApiKey: "AIzaSyDxqb7_tC61JYB3YWv5MY9JlNECUIJIUDQ",
      width: 300,
      height: 264,
      center: Location(-3.1178833, -60.0029284),
      zoom: 10);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getJobInItem();
    itemSelected.value = SelectedListItem(name: "Autre");
  }

  getJobInItem() {
    SelectedListItem selectedListItem1 =
        SelectedListItem(name: "Coiffure", value: "hdhdgdggd");
    SelectedListItem selectedListItem2 =
        SelectedListItem(name: "Peinture", value: "dfsfdsf");
    SelectedListItem selectedListItem3 =
        SelectedListItem(name: "Menuserie", value: "hdhdgdggd");
    SelectedListItem selectedListItem4 =
        SelectedListItem(name: "Forgeron", value: "qqqqqqqq");
    selectedListItems.value.add(selectedListItem1);
    selectedListItems.value.add(selectedListItem2);
    selectedListItems.value.add(selectedListItem3);
    selectedListItems.value.add(selectedListItem4);
  }
}
