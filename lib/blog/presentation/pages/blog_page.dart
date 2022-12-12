import 'dart:convert';

import 'package:duitku/blog/data/models/post_summary.dart';
import 'package:duitku/blog/presentation/pages/post_detail.dart';
import 'package:duitku/common/constants.dart';
import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  Future<List<PostSummary>> fetchPosts() async {
    var url = Uri.parse("$baseUrl/blog/endpoints/get_posts/");
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<PostSummary> posts = [];
    for (var d in data) {
      if (d != null) {
        posts.add(PostSummary.fromJson(d));
      }
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Posts"),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
          future: fetchPosts(),
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
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => TextButton(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            padding: const EdgeInsets.all(24.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black, blurRadius: 2.0)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Text(
                                    snapshot.data![index].title,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Html(
                                    data: snapshot.data![index].firstSentence,
                                    style: {
                                      "h3": Style(
                                        fontSize: const FontSize(14.0),
                                      ),
                                      "p": Style(
                                        fontSize: const FontSize(12.0),
                                      )
                                    }),
                                Text(
                                    "Posted ${timeago.format(snapshot.data![index].pubDate)}",
                                    style: const TextStyle(
                                        fontSize: 12.0, color: Colors.black)),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                    "${snapshot.data![index].getCommentAmount.toString()} comments",
                                    style: const TextStyle(
                                        fontSize: 10.0, color: Colors.grey)),
                              ],
                            ),
                          ),
                          onPressed: () => {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => PostDetailPage(
                                          postId: snapshot.data![index].id,
                                        ))))
                          },
                        ));
              }
            }
          }),
    );
  }
}
