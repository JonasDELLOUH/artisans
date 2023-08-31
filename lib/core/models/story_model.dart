import 'package:artisans/core/models/salon_model.dart';

class StoryModel {
  final String id;
  final String salonId;
  final String content;
  final String videoUrl;
  SalonModel? salonModel;

  StoryModel(
      {required this.content,
        required this.salonId,
        required this.videoUrl,
        required this.id, this.salonModel});

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
        id: json["id"] ?? "",
        salonId: json["salonId"] ?? "",
        content: json["content"] ?? "",
        videoUrl: json["videoUrl"] ?? "",
        salonModel: json["salon"] != null ? SalonModel.fromJson(json["salon"]) : null
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "salonId": salonId,
      "content": content,
      "videoUrl": videoUrl
    };
  }

  static List<StoryModel> fromJsonList(List<dynamic> json) {
    return json.map((storyModel) => StoryModel.fromJson(storyModel)).toList();
  }
}
