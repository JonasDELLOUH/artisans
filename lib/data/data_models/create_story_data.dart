import 'package:artisans/core/models/story_model.dart';

class CreateStoryData {
  StoryModel? storyModel;

  CreateStoryData.fromJson(Map<String, dynamic> json) {
    if(json["post"] != null){
      storyModel = StoryModel.fromJson(json["story"]);
    }
  }
}
