import 'package:flutter/material.dart';

class CreateWalletPage extends StatefulWidget {
  static const routeName = "/wallet/create";

  const CreateWalletPage({super.key});

  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Wallet")),
    );
  }
}
