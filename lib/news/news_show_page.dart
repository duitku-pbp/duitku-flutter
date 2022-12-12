import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:duitku/news/news_page.dart';
import 'package:duitku/news/news_api.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  static const routeName = '/news';
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  //list untuk menyimpan semua data news yang kita ambil dari API
  List<News>? _news;

  //boolean utk menandakan apakah API masih mengambil data atau sudah selesai
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  //fungsi untuk mengambil data dari API dan menyimpannya ke dalam _news
  Future<void> getNews() async {
    _news = await NewsApi.getNews();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: Text('Loading News...'),
            )
          : ListView.builder(
              itemCount: _news!.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.only(
                        left: 100, right: 100, top: 10, bottom: 10),
                    child: Material(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          //open links in new tab

                          Uri urlParse = Uri.parse(_news![index].shortURL);
                          launchUrl(urlParse);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                  width: 150,
                                  height: 100,
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 10, bottom: 10),
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            _news![index].thumbnailImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 600,
                                    margin: const EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      _news![index].title,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(_news![index].resourceType),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            ),
    );
  }
}

