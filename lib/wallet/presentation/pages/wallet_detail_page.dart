import 'package:duitku/wallet/presentation/bloc/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletDetailPage extends StatefulWidget {
  static const routeName = "/wallet/detail";

  const WalletDetailPage({super.key});

  @override
  State<WalletDetailPage> createState() => _WalletDetailPageState();
}

class _WalletDetailPageState extends State<WalletDetailPage> {
  late int _walletId;

  WalletProvider? _walletProv;

  @override
  void initState() {
    _walletProv = context.read<WalletProvider>();
    _walletProv?.resetWalletDetail();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _walletId = ModalRoute.of(context)?.settings.arguments as int;
    _walletProv?.getWalletDetail(_walletId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet Detail")),
      body: RefreshIndicator(
        onRefresh: () async {
          await _walletProv?.getWalletDetail(_walletId);
        },
        child: FutureBuilder(
            future: _walletProv?.getWalletDetail(_walletId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_walletProv!.wallet == null) {
                return const Center(child: Text("Failed to get wallet"));
              }

              return const SizedBox();
            }),
      ),
    );
  }
}
