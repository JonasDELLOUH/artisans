import 'dart:async';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates({required this.latitude, required this.longitude});
}

Future<Coordinates?> openMapsAndGetCoordinates() async {
  const String latitude = '48.858844';
  final String longitude = '2.294351';
  final String label = 'Emplacement du salon';

  final String mapsUrl =
      'geo:$latitude,$longitude?q=$latitude,$longitude($label)';

  if (await launchUrl(Uri.parse(mapsUrl))) {
    final availability = await GoogleApiAvailability.instance
        .checkGooglePlayServicesAvailability();
    if (availability == GooglePlayServicesAvailability.success) {
      final completer = Completer<Coordinates?>();

      uriLinkStream.listen((Uri? uri) {
        if (uri != null && !completer.isCompleted) {
          final queryParams = uri.queryParameters;
          final lat = double.tryParse(queryParams['latitude'] ?? '');
          final long = double.tryParse(queryParams['longitude'] ?? '');
          if (lat != null && long != null) {
            completer.complete(Coordinates(latitude: lat, longitude: long));
          } else {
            completer.complete(null);
          }
        }
      });

      await launchUrl(Uri.parse(mapsUrl));
      await Future.delayed(const Duration(seconds: 60));

      return completer.isCompleted ? completer.future : null;
    } else {
      debugPrint('Google Play Services ne sont pas disponibles.');
      return null;
    }
  } else {
    debugPrint("Impossible d'ouvrir l'application de cartographie.");
    return null;
  }
}

Future<String?> getAddressFromCoordinates(
    double latitude, double longitude) async {
  try {
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      debugPrint("placemarks :$placemarks");
      final Placemark placemark = placemarks[0];
      final String address =
          "${placemark.administrativeArea ?? ''}, ${placemark.locality ?? ''}, ${placemark.subLocality ?? ''}";
      return address;
    } else {
      return null;
    }
  } catch (e) {
    debugPrint('Erreur lors de la récupération de l\'adresse : $e');
    return null;
  }
}

/// Navigate to the selectLocation screen and return the selected LatLng or null.
Future<LatLng?> selectPosition() async {
  return await Get.toNamed(AppRoutes.selectLocationRoute) as LatLng?;
}

Future<Position?> getCurrentPosition() async {
  // Request location permission from the user.
  var permission = await Geolocator.requestPermission();

  // Check if the permission is granted and location service is enabled.
  if (![LocationPermission.always, LocationPermission.whileInUse]
          .contains(permission) ||
      !await Geolocator.isLocationServiceEnabled()) {
    return null; // Permission denied or location service is disabled.
  }

  // Retrieve the current device's position with high accuracy.
  return Geolocator.getLastKnownPosition();
}

Future<LatLng?> getCurrentLatLng() async {
  // Get the current device's position using getCurrentPosition function.
  Position? position = await getCurrentPosition();

  // Return LatLng if the position is available, otherwise return null.
  return position != null
      ? LatLng(position.latitude, position.longitude)
      : null;
}
