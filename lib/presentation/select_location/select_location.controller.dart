import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/functions/basics_functions.dart';
import '../../core/functions/map_functions.dart';
import '../../core/models/locality_model.dart';
import '../../core/routes/app_routes.dart';
import '../../data/services/recent_location_service.dart';

class SelectLocationController extends GetxController {
  bool isNeverOrder = false;
  RxBool processing = false.obs;
  late LatLng? _deviceLocation = const LatLng(0, 0);
  final RecentLocalityService _recentLocationService =
      Get.put(RecentLocalityService());

  @override
  void onInit() {
    getCurrentLatLng().then((value) {
      if (value != null) _deviceLocation = value;
    });
    super.onInit();
  }

  LatLng get lastDevicePosition {
    getCurrentLatLng().then((value) => _deviceLocation = value);
    return _deviceLocation ?? const LatLng(0, 0);
  }

  RxList<LocalityModel> get recentLocalities =>
      _recentLocationService.recentLocalities;

  bool get noRecentLocality => recentLocalities.isEmpty;

  /// Initiates the selection of the current device's location by obtaining its
  /// LatLng and returning it. This function sets the [processing] flag to true
  /// during execution and sets it back to false upon completion.
  void selectCurrentPosition() async {
    // Set the processing flag to true to indicate that a selection is in progress.
    processing.value = true;

    // Return the current device's LatLng by navigating back with the result.
    Get.back<LatLng?>(result: await getCurrentLatLng());

    // Set the processing flag to false to indicate that the selection is complete.
    processing.value = false;
  }

  /// Initiates the selection of a location based on a provided [locality].
  /// It sets the [processing] flag to true, sets the [locality] as a recent selection,
  /// and returns the [locality]'s coordinates. The [processing] flag is set back to
  /// false upon completion.
  ///
  /// Parameters:
  /// - [locality]: The selected locality model to set as the recent selection.
  void selectPosition(LocalityModel locality) async {
    // Set the processing flag to true to indicate that a selection is in progress.
    processing.value = true;

    // Set the provided [locality] as a recent selection.
    _recentLocationService.setRecentLocality(locality);

    // Return the [locality]'s coordinates by navigating back with the result.
    Get.back<LatLng?>(result: locality.coordinates);

    // Set the processing flag to false to indicate that the selection is complete.
    processing.value = false;
  }

  /// Initiates the selection of a location from a map by navigating to the
  /// "selectOwnLocation" route. If a locality is selected from the map, it
  /// calls the `selectPosition` function with the selected locality.
  ///
  /// This function handles the user's interaction with the map for location
  /// selection. If an error occurs during the process, it catches and suppresses
  /// the exception.
  void selectFromMap() async {
    processing.value = true;
    try {
      // Navigate to the "selectOwnLocation" route and await a LocalityModel result.
      LocalityModel? locality =
          await Get.toNamed(AppRoutes.selectOwnLocationOnMapRoute) as LocalityModel?;

      // If a locality is selected, call selectPosition with the selected locality.
      if (locality != null) {
        selectPosition(locality);
      } else {
        toast("aucune position sélectionnée");
      }
    } catch (e) {
      // Handle any exceptions that may occur during the location selection process.
    } finally {
      processing.value = false;
    }
  }

  /// Clear recent localities
  void clearRecentLocalities() {
    _recentLocationService.clearRecentLocalities();
  }
}
