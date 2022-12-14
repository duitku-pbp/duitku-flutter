import 'package:duitku/investasiku/data/portofolio_models.dart';
import 'package:duitku/investasiku/data/map.dart';
import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors

class PortofolioDetail extends StatelessWidget {
  final Portofolio data;
  const PortofolioDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Column(
          children: [
            Center(
              child: Text(namemap[data.investment],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
            ),
            Row(
              children: [
                Text("Nilai Portofolio : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(data.boughtValue.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
              ],
            ),
          ],
        ),
      
      persistentFooterButtons: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Back',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}