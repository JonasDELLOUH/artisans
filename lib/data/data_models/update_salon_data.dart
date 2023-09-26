import '../../core/models/salon_model.dart';

class UpdateSalonData {
  SalonModel? salonModel;

  UpdateSalonData.fromJson(Map<String, dynamic> json) {
    if(json["updatedSalon"] != null){
      salonModel = SalonModel.fromJson(json["updatedSalon"]);
    }
  }
}