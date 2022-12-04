import 'package:duitku/wallet/data/models/wallet.dart';
import 'package:duitku/wallet/presentation/providers/wallet_provider.dart';
import 'package:duitku/wallet/presentation/widgets/report_card.dart';
import 'package:duitku/wallet/presentation/widgets/wallet_scaffold.dart';
import 'package:duitku/wallet/presentation/widgets/wallet_tiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletHomePage extends StatefulWidget {
  static const routeName = "/wallet";

  const WalletHomePage({super.key});

  @override
  State<WalletHomePage> createState() => _WalletHomePageState();
}

class _WalletHomePageState extends State<WalletHomePage> {
  WalletProvider? _walletProv;

  double _total = 0;

  @override
  void initState() {
    _walletProv = Provider.of<WalletProvider>(context, listen: false);
    _walletProv?.getWallets();

    _setTotalBalance();
    super.initState();
  }

  void _setTotalBalance() {
    double total = 0;
    final wallets = _walletProv?.wallets ?? [];

    for (Wallet wallet in wallets) {
      total += wallet.balance;
    }

    setState(() {
      _total = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WalletScaffold(
      idx: 0,
      title: "My Wallets",
      body: RefreshIndicator(
        child: FutureBuilder(
          future: _walletProv?.getWallets(),
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
                    const Text(
                      "Report",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 18),
                    const ReportCard(),
                    const SizedBox(height: 40),
                    const Text(
                      "My Wallets",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 7),
                    Text(
                      "Rp. $_total",
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 18),
                    WalletTiles(wallets: _walletProv?.wallets ?? []),
                  ],
                ),
              ),
            );
          },
        ),
        onRefresh: () async {
          await _walletProv?.getWallets();
          _setTotalBalance();
        },
      ),
    );
  }
}
