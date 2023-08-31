import 'package:artisans/core/models/post_model.dart';
import 'package:artisans/core/models/salon_model.dart';

class CreatePostData {
  PostModel? postModel;

  CreatePostData.fromJson(Map<String, dynamic> json) {
    postModel = PostModel.fromJson(json);
  }
}
