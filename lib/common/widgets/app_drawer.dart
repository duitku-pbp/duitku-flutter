import 'package:duitku/auth/presentation/pages/login_page.dart';
import 'package:duitku/auth/presentation/bloc/providers/auth_provider.dart';
import 'package:duitku/donasi/presentation/pages/donasi_page.dart';
import 'package:duitku/investasiku/presentation/home_investasiku.dart';
import 'package:duitku/main.dart';
import 'package:duitku/wallet/presentation/pages/wallet_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duitku/news/news_show_page.dart';
import 'package:duitku/blog/presentation/pages/blog_page.dart';

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
          authProv!.isAuthenticated
              ? ListTile(
                  title: const Text(
                    "Blogs",
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: const Icon(Icons.public),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BlogPage()));
                  },
                )
              : const SizedBox(),
          ListTile(
            title: const Text("News", style: TextStyle(fontSize: 16)),
            leading: const Icon(Icons.newspaper),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(NewsPage.routeName);
            },
          ),
          authProv!.isAuthenticated
              ? ListTile(
                  title: const Text(
                    "Donasi",
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: const Icon(Icons.money),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(DonasiHomePage.routeName);
                  },
                )
              : const SizedBox(),
          authProv!.isAuthenticated
              ? ListTile(
                  title: const Text(
                    "Investasiku",
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: const Icon(Icons.money),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeInvestasikuPage()),
                    );
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
          ),
        ],
      ),
    );
  }
}
