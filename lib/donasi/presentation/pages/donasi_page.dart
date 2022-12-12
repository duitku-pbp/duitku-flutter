import 'package:flutter/material.dart';
import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:duitku/donasi/presentation/widgets/donasi_tiles.dart';
import 'package:duitku/donasi/presentation/bloc/providers/donasi_provider.dart';
import 'package:duitku/donasi/presentation/pages/add_donasi.dart';
import 'package:provider/provider.dart';

class DonasiHomePage extends StatefulWidget{
  static const routeName = "/donasi";

  const DonasiHomePage({super.key});

  @override
  State<DonasiHomePage> createState() => _DonasiHomePageState();
}

class _DonasiHomePageState extends State<DonasiHomePage> {
  DonasiProvider? _donasiProv;

  @override
  void initState() {
    _donasiProv = Provider.of<DonasiProvider>(context, listen: false);
    _donasiProv?.getDonasi();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Donasi'),
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        child: FutureBuilder(
          future: _donasiProv?.getDonasi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      "Donasi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 7),
                    DonasiTiles(donasi: _donasiProv?.donasi ?? []),
                  ],
                ),
              ),
            );
          },
        ),
        onRefresh: () async {
          await _donasiProv?.getDonasi();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed(AddDonasiPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}