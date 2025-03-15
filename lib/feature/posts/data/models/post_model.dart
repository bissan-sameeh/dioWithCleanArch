import 'package:flutt_pro/feature/posts/domain/entity/post_entity.dart';

class PostModel extends Post{
  const PostModel({ super.id, required super.title, required super.body});
  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
  };

}