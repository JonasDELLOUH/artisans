import 'package:artisans/core/models/post_model.dart';

class GetPostsData{
  List<PostModel>? posts;
  int skip = 0;
  int limit = 10;
  int count = 10;

  GetPostsData({this.posts});

  GetPostsData.fromJson(Map<String, dynamic> json) {
    skip = json["skip"];
    limit = json["limit"];
    posts = <PostModel>[];
    for (var element in json["posts"]) {
      posts!.add(PostModel.fromJson(element));
    }
  }
}