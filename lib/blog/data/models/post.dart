// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'package:duitku/blog/data/models/comment.dart';
import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.id,
    required this.title,
    required this.pubDate,
    required this.content,
    required this.upvotes,
    required this.comments,
  });

  int id;
  String title;
  DateTime pubDate;
  String content;
  int upvotes;
  List<Comment> comments;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        pubDate: DateTime.parse(json["pub_date"]),
        content: json["content"],
        upvotes: json["upvotes"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "pub_date": pubDate.toIso8601String(),
        "content": content,
        "upvotes": upvotes,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}
