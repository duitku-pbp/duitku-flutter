import 'package:duitku/investasiku/data/investasi_models.dart';
import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors

class InvestasiDetail extends StatelessWidget {
  final Investasi data;
  const InvestasiDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Reksadana'),
      ),
      body: Column(
          children: [
            Center(
              child: Text(data.investmentName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
            ),
            Row(
              children: [
                Text("Tipe Investasi : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(data.investmentType,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Text("CAGR 1Y : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(data.cagr_1Y.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Text("Drawdown 1Y : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(data.drawdown_1Y.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Text("AUM : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(data.aum.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Text("Expense Ratio : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(data.expenseRatio.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Text("Minimum Pembelian : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(data.minBuy.toString(),
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