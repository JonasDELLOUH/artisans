import 'package:get/get.dart';
import '../../core/models/locality_model.dart';
import 'my_get_storage.dart';

class RecentLocalityService extends GetxService {
  late RxList<LocalityModel> recentLocalities;

  @override
  void onInit() {
    recentLocalities = _loadRecentLocalities().obs;
    super.onInit();
  }

  List<LocalityModel> _loadRecentLocalities() {
    try {
      return List.from(MyGetStorage.instance.read("RecentLocalities") ?? [])
          .map((e) => LocalityModel.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  void _persistRecentLocalities() {
    MyGetStorage.instance.write(
        "RecentLocalities", recentLocalities.map((e) => e.toJson()).toList());
  }

  void _deleteRecentLocality(LocalityModel newLocation) {
    recentLocalities.removeWhere(
        (element) => element.coordinates == newLocation.coordinates);
  }

  void setRecentLocality(LocalityModel locality) {
    _deleteRecentLocality(locality);
    recentLocalities.insert(0, locality);
    _persistRecentLocalities();
    _resizeRecentlocalities();
  }

  void removeRecentLocality(LocalityModel locality) {
    _deleteRecentLocality(locality);
    _persistRecentLocalities();
  }

  void clearRecentLocalities() {
    recentLocalities.clear();
    _persistRecentLocalities();
  }

  void _resizeRecentlocalities() {
    if (recentLocalities.length > 6) {
      recentLocalities.removeLast();
    }
  }
}
