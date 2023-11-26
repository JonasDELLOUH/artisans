import 'package:flutter/cupertino.dart';

import '../../core/models/salon_model.dart';

class GetSalonsData {
  List<SalonModel>? salons;
  int? page = 0;
  int? totalPage = 0;
  int? totalItems = 10;
  bool? hasPrev = false;
  bool? hasNext = false;
  String? message;
  bool? status;

  GetSalonsData({this.salons});

  GetSalonsData.fromJson(Map<String, dynamic> json) {
    page = json["data"]["page"];
    totalPage = json["data"]["total_pages"];
    totalItems = json["data"]["total_items"];
    hasPrev = json["data"]["has_prev"] ?? false;
    hasNext = json["data"]["has_next"] ?? false;
    message = json["message"];
    status = json["status"];
    salons = <SalonModel>[];
    for (var element in json["data"]["items"]) {
      salons!.add(SalonModel.fromJson(element));
    }
  }
}
