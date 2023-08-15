import 'package:artisans/core/models/salon_model.dart';

class CreateSalonData {
  SalonModel? salonModel;

  CreateSalonData.fromJson(Map<String, dynamic> json) {
    salonModel = SalonModel.fromJson(json);
  }
}
