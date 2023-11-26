import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../secret.dart';
import '../data_models/reverse_geocoding_data.dart';
import '../providers/dio_provider.dart';

class ReverseGeocodingService {
  static Future<String> reverseGeocoding(LatLng position) async {
    try {
      var data = {
        "latlng": "${position.latitude},${position.longitude}",
        "key": Secret.googleApiKey,
      };
      var response = await DioProvider.client.get(
        "https://maps.googleapis.com/maps/api/geocode/json",
        queryParameters: data,
      );
      if (response.statusCode == HttpStatus.ok) {
        return ReverseGeocodingData.fromJson(response.data).formattedAddress;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }
}
