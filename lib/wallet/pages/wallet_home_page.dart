import 'package:duitku/common/widgets/app_drawer.dart';
import 'package:duitku/wallet/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duitku/injection.dart' as di;

class WalletHomePage extends StatefulWidget {
  static const routeName = "/wallet";

  const WalletHomePage({super.key});

  @override
  State<WalletHomePage> createState() => _WalletHomePageState();
}

class _WalletHomePageState extends State<WalletHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di.sl<WalletProvider>(),
      child: Scaffold(
        appBar: AppBar(title: const Text("My Wallets")),
        drawer: const AppDrawer(),
      ),
    );
  }
}
