import 'package:artisans/core/models/post_model.dart';
import 'package:artisans/core/models/story_model.dart';

class GetStoriesData {
  List<StoryModel>? stories;
  int skip = 0;
  int limit = 10;
  int count = 10;

  GetStoriesData({this.stories});

  GetStoriesData.fromJson(Map<String, dynamic> json) {
    skip = json["skip"];
    limit = json["limit"];
    stories = <StoryModel>[];
    for (var element in json["stories"]) {
      stories!.add(StoryModel.fromJson(element));
    }
  }
}
