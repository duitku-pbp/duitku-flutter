import 'package:duitku/wallet/models/wallet.dart';
import 'package:flutter/material.dart';

class WalletTiles extends StatelessWidget {
  final List<Wallet> wallets;

  const WalletTiles({super.key, required this.wallets});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx, i) => Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: i == 0
                ? const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )
                : i == wallets.length - 1
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      )
                    : BorderRadius.circular(0),
          ),
          child: ListTile(
            title: Text(
              wallets[i].name,
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              "Rp. ${wallets[i].balance}",
              style: TextStyle(
                color: wallets[i].balance >= 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
        ),
        itemCount: wallets.length,
      ),
    );
  }
}
