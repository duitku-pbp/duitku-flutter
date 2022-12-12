import 'package:duitku/investasiku/data/map.dart';
import 'package:duitku/investasiku/presentation/investasiList.dart';
import 'package:duitku/investasiku/presentation/provider/investasiku_provider.dart';
import 'package:duitku/investasiku/presentation/portofolioDetails.dart';
import 'package:flutter/material.dart';
import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
class HomeInvestasikuPage extends StatefulWidget {
  const HomeInvestasikuPage({super.key});
  static const routeName = "/investasiku";

  @override
  State<HomeInvestasikuPage> createState() => HomeInvestasikuPageState();
}

class HomeInvestasikuPageState extends State<HomeInvestasikuPage> {
  PortofolioProvider? _portofolioProv;
  
  void initState() {
    _portofolioProv = Provider.of<PortofolioProvider>(context, listen: false);
    _portofolioProv?.getPortofolio();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Portofolio Investasiku'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: _portofolioProv?.getPortofolio(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
               else {
                if (_portofolioProv!.portofolio.isEmpty) {
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
                      itemCount: _portofolioProv?.portofolio.length,
                      itemBuilder: (_, index) => ListTile(
                          
                          title: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PortofolioDetail(
                                          data: _portofolioProv!.portofolio[index])));
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
                                    namemap[_portofolioProv!.portofolio[index].investment],
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
            }),
            floatingActionButton: FloatingActionButton(
                      onPressed: () {
                  // Route menu ke halaman utama
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const InvestasiListPage()),
                  );
                },
                      tooltip: 'Lihat Investasi',
                      child: const Icon(Icons.money),
                    ),);
  }
}