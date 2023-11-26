import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalityModel {
  final String name;
  LatLng? coordinates;

  LocalityModel({required this.name, this.coordinates});

  factory LocalityModel.fromJson(dynamic json) {
    late LocalityModel localityModel;
    if(json is String){
      localityModel = LocalityModel(name: json ?? "");
    }else{
      localityModel = LocalityModel(
        name: json['name'] ?? json ?? "",
        coordinates: json["coordinates"] != null
            ? LatLng(
          json["coordinates"]['latitude'] ?? 0,
          json["coordinates"]['longitude'] ?? 0,
        )
            : null,
      );
    }
    return localityModel;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      if (coordinates != null)
        "coordinates": {
          "latitude": coordinates!.latitude,
          "longitude": coordinates!.longitude,
        },
    };
  }

  String get description {
    if (name.isNotEmpty) {
      return name;
    } else if (coordinates != null) {
      return "(${coordinates?.latitude}, ${coordinates?.longitude})";
    } else {
      return "---";
    }
  }
}
