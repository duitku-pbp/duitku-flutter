import 'package:duitku/auth/pages/login_page.dart';
import 'package:duitku/auth/providers/auth_provider.dart';
import 'package:duitku/main.dart';
import 'package:duitku/wallet/pages/wallet_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  AuthProvider? authProv;

  Future<void> _logout(BuildContext context, [bool mounted = true]) async {
    await authProv?.logout();

    if (mounted) {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    }
  }

  @override
  void initState() {
    authProv = Provider.of<AuthProvider>(context, listen: false);

    super.initState();
  }

  void _login(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.green),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        authProv!.isAuthenticated
                            ? "Logged In"
                            : "Logged in as Guest",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 16),
            ),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MyHomePage.routeName);
            },
          ),
          authProv!.isAuthenticated
              ? ListTile(
                  title: const Text(
                    "Wallet",
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: const Icon(Icons.wallet),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(WalletHomePage.routeName);
                  },
                )
              : const SizedBox(),
          const Divider(
            height: 3,
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
              authProv!.isAuthenticated ? "Logout" : "Login",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.logout),
            onTap: () async {
              if (authProv!.isAuthenticated) {
                await _logout(context);
              } else {
                _login(context);
              }
            },
          )
        ],
      ),
    );
  }
}
