import 'package:duitku/auth/pages/login_page.dart';
import 'package:duitku/auth/providers/auth_provider.dart';
import 'package:duitku/wallet/pages/wallet_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<void> _logout(BuildContext context, [bool mounted = true]) async {
    await Provider.of<AuthProvider>(context, listen: false).logout();

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "Wallet",
              style: TextStyle(fontSize: 16),
            ),
            leading: const Icon(Icons.wallet),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(WalletHomePage.routeName);
            },
          ),
          const Divider(
            height: 3,
            color: Colors.grey,
          ),
          ListTile(
            title: const Text(
              "Logout",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await _logout(context);
            },
          ),
        ],
      ),
    );
  }
}
