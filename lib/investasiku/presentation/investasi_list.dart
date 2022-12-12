import 'package:duitku/investasiku/presentation/investasi_details.dart';
import 'package:flutter/material.dart';
import 'package:duitku/investasiku/data/fetch_investasi.dart';
import 'package:duitku/common/widgets/app_drawer.dart';
class InvestasiListPage extends StatefulWidget {
  const InvestasiListPage({super.key});
  static const routeName = "/investasiku/reksadanalist";
  @override
  State<InvestasiListPage> createState() => _InvestasiListPageState();
}

class _InvestasiListPageState extends State<InvestasiListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Reksadana Untukmu'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: fetchInvestasi(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Tidak ada Portofolio :(",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => ListTile(
                          
                          title: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InvestasiDetail(
                                          data: snapshot.data![index])));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: const Color(0xFFFFFFFF)),
                                      boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromARGB(255, 143, 143, 143),
                                              blurRadius: 2.0,
                                              offset: Offset(0, 2),)
                                        ]
                                  ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].investmentName,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )));
                }
              }
            })
        );
  }
}