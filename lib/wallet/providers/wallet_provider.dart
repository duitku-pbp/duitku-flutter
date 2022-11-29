import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class WalletProvider with ChangeNotifier {
  final http.Client client;

  WalletProvider({required this.client});
}
