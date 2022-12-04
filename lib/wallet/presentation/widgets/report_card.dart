import 'package:duitku/wallet/presentation/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportCard extends StatefulWidget {
  const ReportCard({super.key});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  final dateFormatter = DateFormat("yyyy-MM");
  final now = DateTime.now();
  List<String> _periods = [];

  Future<void>? _getReport;
  WalletProvider? walletProv;
  String? _period;

  void _setPeriods() {
    final dates = <String>[];

    for (int i = 0; i > -12; i--) {
      final date = DateTime(now.year, now.month + i, 1);
      dates.add(dateFormatter.format(date));
    }

    setState(() {
      _periods = dates;
      _period = dates[0];
    });
  }

  @override
  void initState() {
    walletProv = Provider.of<WalletProvider>(context, listen: false);
    _setPeriods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: FutureBuilder(
        future: _getReport ?? walletProv?.getReport(_period!),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(8),
                          value: _period,
                          items: _periods
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _period = val;
                              _getReport = walletProv?.getReport(_period!);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Income",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Outcome",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "+${walletProv!.report?.income ?? 0}",
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  Text(
                    "-${walletProv!.report?.outcome ?? 0}",
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Net Income",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${walletProv!.report?.netIncome ?? 0}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
