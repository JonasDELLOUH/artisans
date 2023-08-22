import '../../core/models/salon_model.dart';

class GetSalonsData {
  List<SalonModel>? salons;
  int skip = 0;
  int limit = 10;
  int count = 10;

  GetSalonsData({this.salons});

  GetSalonsData.fromJson(Map<String, dynamic> json) {
    skip = json["skip"];
    limit = json["limit"];
    salons = <SalonModel>[];
    for (var element in json["salons"]) {
      salons!.add(SalonModel.fromJson(element));
    }
  }
}
