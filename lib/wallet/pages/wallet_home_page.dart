import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:duitku/wallet/models/wallet.dart';
import 'package:duitku/wallet/providers/wallet_provider.dart';
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
  WalletProvider? walletProv;

  @override
  void initState() {
    walletProv = Provider.of<WalletProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Wallets")),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: walletProv!.wallets.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(walletProv!.wallets[i].name),
              ),
            );
          },
          future: _getWallets,
        ),
        onRefresh: () {
          setState(() {
            _getWallets = walletProv?.getWallets();
          });
          return _getWallets!;
        },
      ),
    );
  }
}
