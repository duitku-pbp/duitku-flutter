import 'dart:convert';

import 'package:duitku/blog/data/models/comment.dart';
import 'package:duitku/blog/data/models/post.dart';
import 'package:duitku/blog/presentation/widgets/create_comment_dialog.dart';
import 'package:duitku/common/constants.dart';
import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key, required this.postId});

  final num postId;

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  void refetch() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Posts"),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: fetchPostDetail(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Column(
                children: const [
                  Text(
                    "Tidak ada blog post :(",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          snapshot.data!.title,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Html(data: snapshot.data!.content, style: {
                        "h3": Style(
                          fontSize: const FontSize(14.0),
                        ),
                        "p": Style(
                          fontSize: const FontSize(12.0),
                        )
                      }),
                      const Divider(
                        height: 16.0,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text("Comments",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ..._getComments(snapshot.data!.comments),
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.all(8.0)),
                            onPressed: () => {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CreateCommentDialog(
                                        postId: widget.postId,
                                        refetch: refetch);
                                  })
                            },
                            child: const Text("Add Your Comment!"),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                        ],
                      )
                    ],
                  )));
            }
          }
        },
      ),
    );
  }

  Future<Post> fetchPostDetail() async {
    var url = Uri.parse("$baseUrl/blog/endpoints/${widget.postId}");
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    return Post.fromJson(data);
  }

  List<Widget> _getComments(List<Comment> comments) {
    return comments
        .map((Comment comment) => Column(children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.greenAccent, width: 2)),
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(timeago.format(comment.pubDate),
                              style: const TextStyle(fontSize: 9.0)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                comment.user,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(comment.content,
                                  style: const TextStyle(fontSize: 12.0))
                            ],
                          ),
                        ],
                      ))),
              const SizedBox(
                height: 10.0,
              )
            ]))
        .toList();
  }
}
