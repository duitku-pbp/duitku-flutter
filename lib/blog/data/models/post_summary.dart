import 'dart:convert';

PostSummary postSummaryFromJson(String str) =>
    PostSummary.fromJson(json.decode(str));

String postSummaryToJson(PostSummary data) => json.encode(data.toJson());

class PostSummary {
  PostSummary({
    required this.id,
    required this.title,
    required this.upvotes,
    required this.firstSentence,
    required this.pubDate,
    required this.getCommentAmount,
  });

  int id;
  String title;
  int upvotes;
  String firstSentence;
  DateTime pubDate;
  int getCommentAmount;

  factory PostSummary.fromJson(Map<String, dynamic> json) => PostSummary(
        id: json["id"],
        title: json["title"],
        upvotes: json["upvotes"],
        firstSentence: json["first_sentence"],
        pubDate: DateTime.parse(json["pub_date"]),
        getCommentAmount: json["get_comment_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "upvotes": upvotes,
        "first_sentence": firstSentence,
        "pub_date": pubDate.toIso8601String(),
        "get_comment_amount": getCommentAmount,
      };
}
