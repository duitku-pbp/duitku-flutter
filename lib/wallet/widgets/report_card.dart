import 'package:duitku/wallet/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportCard extends StatefulWidget {
  const ReportCard({
    super.key,
  });

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  final dateFormatter = DateFormat("yyyy-MM");
  final now = DateTime.now();
  List<String> _periods = [];

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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _period,
                    items: _periods
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _period = val;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
