// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    required this.id,
    required this.user,
    required this.content,
    required this.pubDate,
  });

  int id;
  String user;
  String content;
  DateTime pubDate;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        user: json["user"],
        content: json["content"],
        pubDate: DateTime.parse(json["pub_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "content": content,
        "pub_date": pubDate.toIso8601String(),
      };
}
