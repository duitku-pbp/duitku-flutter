import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:duitku/wallet/providers/wallet_provider.dart';
import 'package:duitku/wallet/widgets/wallet_tiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletHomePage extends StatefulWidget {
  static const routeName = "/wallet";

  const WalletHomePage({super.key});

  @override
  State<WalletHomePage> createState() => _WalletHomePageState();
}

class _WalletHomePageState extends State<WalletHomePage> {
  Future<void>? _getWallets;
  Future<void>? _getReport;
  WalletProvider? walletProv;
  double _total = 0;

  @override
  void initState() {
    walletProv = Provider.of<WalletProvider>(context, listen: false);
    _setTotal();
    super.initState();
  }

  void _setTotal() {
    final wallets = walletProv?.wallets;
    if (wallets == null || wallets.isEmpty) {
      return;
    }

    final total = wallets.reduce((total, wallet) {
      total.balance += wallet.balance;
      return total;
    }).balance;

    setState(() {
      _total = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Wallets")),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        child: FutureBuilder(
          future: Future.wait(
            [
              _getWallets ?? walletProv!.getWallets(),
              _getReport ?? walletProv!.getReport("2022-11"),
            ],
            eagerError: true,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 17),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    WalletTiles(wallets: walletProv?.wallets ?? []),
                  ],
                ),
              ),
            );
          },
        ),
        onRefresh: () {
          setState(() {
            _getWallets = walletProv?.getWallets();
            _getReport = walletProv?.getReport("2022-11");
          });

          _setTotal();

          return Future.wait(
            [
              _getWallets ?? walletProv!.getWallets(),
              _getReport ?? walletProv!.getReport("2022-11"),
            ],
            eagerError: true,
          );
        },
      ),
    );
  }
}
