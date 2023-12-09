import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/models/salon_model.dart';
import '../../data/services/app_services.dart';

class SalonsMapController extends GetxController {
  Rx<Set<Marker>> markers = Rx<Set<Marker>>({});
  GoogleMapController? mapController;
  Rx<List<SalonModel>> salons = Rx<List<SalonModel>>([]);
  final appServices = Get.find<AppServices>();

  late Rx<LatLng> initialPosition = Rx<LatLng>(
      LatLng(appServices.latitude.value, appServices.longitude.value));

  @override
  void onInit() {
    super.onInit();
    salons.value = Get.arguments[0];
    loadMarkers();
  }

  Future<BitmapDescriptor> createCustomIcon() async {
    try {
      return await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(20, 20)),
        // "assets/icons/artisan_logo1.jpeg",
        "assets/artisan_marker.jpeg"
      );
    } catch (e) {
      debugPrint("Voici l'erreur: $e");
      return BitmapDescriptor.defaultMarker;
    }
  }

  Future<void> loadMarkers() async {
    markers.value = {};
    BitmapDescriptor customIcon = await createCustomIcon();
    for (SalonModel salonModel in salons.value) {
      markers.value.add(
        Marker(
          markerId: MarkerId(salonModel.salonId),
          position: LatLng(salonModel.latitude, salonModel.longitude),
          icon: customIcon,
          onTap: () async {
            // onTapPharmacy(pharmacyModel);
          },
        ),
      );
    }
    markers.refresh();
  }
}