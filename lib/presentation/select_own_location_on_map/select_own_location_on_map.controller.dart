import 'package:artisans/data/services/app_services.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/models/locality_model.dart';
import '../../data/services/reverse_geo.service.dart';

class SelectOwnLocationOnMapController extends GetxController {
  late Rx<MapType> mapType;
  late final Rx<String?> locationName;
  GoogleMapController? mapController;
  final appGetServices = Get.find<AppServices>();
  String _name = "";

  late Rx<LatLng> selectedlocation = const LatLng(0, 0).obs;

  @override
  void onInit() {
    mapType = MapType.normal.obs;
    locationName = "".obs;
    updateSelectedlocation(
      LatLng(
        appGetServices.latitude.value,
        appGetServices.longitude.value,
      ),
    );
    super.onInit();
  }

  Future<void> retreivePositionAddressName(LatLng position) async {
    buildLocationName(await ReverseGeocodingService.reverseGeocoding(position));
  }

  void switchMapType() {
    int index = MapType.values.indexOf(mapType.value);
    mapType.value = MapType.values.elementAt(
      (index + 1) % MapType.values.length,
    );
    if (mapType.value == MapType.none) switchMapType();
  }

  Future<void> handleCameraMove(CameraPosition position) async {
    updateSelectedlocation(position.target);
  }

  void updateSelectedlocation(LatLng newLocation) {
    selectedlocation.value = newLocation;
    buildLocationName();
    getSelectesLocationName();
  }

  void getSelectesLocationName() {
    EasyDebounce.debounce(
        "getSelectesLocationName", const Duration(milliseconds: 200), () {
      retreivePositionAddressName(selectedlocation.value);
    });
  }

  void buildLocationName([String name = ""]) {
    _name = name;
    if (name.isNotEmpty) {
      locationName.value = name;
    } else {
      locationName.value =
          "(${selectedlocation.value.latitude}, ${selectedlocation.value.longitude})";
    }
  }

  void selectLocation() {
    LocalityModel result = LocalityModel(
      name: _name,
      coordinates: selectedlocation.value,
    );
    Get.back(result: result);
  }

  @override
  void onClose() {
    mapController?.dispose();
    super.onClose();
  }
}
