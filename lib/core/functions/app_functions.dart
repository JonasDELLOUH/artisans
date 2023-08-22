import 'dart:math';

import 'package:artisans/core/services/my_get_storage.dart';
import 'package:get_storage/get_storage.dart';
 deleteGetStorageKey({required String key}){
  return MyGetStorage.instance.remove(key);
}

addInGetStorage({required String key, dynamic data}){
   return MyGetStorage.instance.write(key, data);
}

dynamic getInGetStorage({required String key}){
   return MyGetStorage.instance.read(key);
}

eraseGetStorage(){
   return MyGetStorage.instance.erase();
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371000.0; // Rayon moyen de la Terre en mètres

  double dLat = (lat2 - lat1) * (pi / 180);
  double dLon = (lon2 - lon1) * (pi / 180);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * (pi / 180)) *
          cos(lat2 * (pi / 180)) *
          sin(dLon / 2) *
          sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c; // Distance en mètres
  return distance;
}



