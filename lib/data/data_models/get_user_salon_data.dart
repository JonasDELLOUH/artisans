import 'package:artisans/core/models/salon_model.dart';

class GetUserSalonData{
  SalonModel? salonModel;
  bool hasSalon = false;

  GetUserSalonData({this.salonModel});

  GetUserSalonData.fromJson(Map<String, dynamic> json) {
    hasSalon = json["hasSalon"];
    if(json["salon"] != null){
      salonModel = SalonModel.fromJson(json["salon"]);
    }
  }
}