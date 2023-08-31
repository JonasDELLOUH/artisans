import 'package:artisans/core/models/salon_model.dart';

class PostModel {
  final String id;
  final String salonId;
  final String content;
  final String imageUrl;
  SalonModel? salonModel;

  PostModel(
      {required this.content,
      required this.salonId,
      required this.imageUrl,
      required this.id, this.salonModel});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json["id"] ?? "",
        salonId: json["salonId"] ?? "",
        content: json["content"] ?? "",
        imageUrl: json["imageUrl"] ?? "",
        salonModel: json["salon"] != null ? SalonModel.fromJson(json["salon"]) : null
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "salonId": salonId,
      "content": content,
      "imageUrl": imageUrl
    };
  }

  static List<PostModel> fromJsonList(List<dynamic> json) {
    return json.map((postModel) => PostModel.fromJson(postModel)).toList();
  }
}
