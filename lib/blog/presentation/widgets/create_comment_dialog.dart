import 'package:duitku/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateCommentDialog extends StatefulWidget {
  const CreateCommentDialog(
      {super.key, required this.postId, required this.refetch});

  final Function() refetch;
  final num postId;

  @override
  State<CreateCommentDialog> createState() => _CreateCommentDialogState();
}

class _CreateCommentDialogState extends State<CreateCommentDialog> {
  Future<void> postNewComment(content) async {
    var url =
        Uri.parse("$baseUrl/blog/endpoints/add_comment/${widget.postId}/");
    var response = await http.post(url, body: {"content": content});
    if (response.statusCode != 200) {
      return Future.error(response.bodyBytes);
    }
  }

  final _formKey = GlobalKey<FormState>();
  String _commentContent = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Wrap(
          children: [
            Form(
              key: _formKey,
              child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Center(
                        child: Text("Write Your Own Comment!",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        maxLines: 6,
                        decoration: InputDecoration(
                            labelText: "Your Comment",
                            hintText: "Example: I love this app!",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        onChanged: (String? value) {
                          setState(() {
                            _commentContent = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            _commentContent = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Komentar tidak boleh string kosong :(";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      Center(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.all(8.0)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  postNewComment(_commentContent);
                                  widget.refetch();
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text("Post Your Comment"))),
                    ],
                  )),
            ),
          ],
        ));
  }
}
