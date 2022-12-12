import 'package:duitku/investasiku/data/portofolio_models.dart';
import 'package:duitku/investasiku/data/repositories/investasiku_repositories.dart';
import 'package:flutter/foundation.dart';

class PortofolioProvider with ChangeNotifier {
  final InvestasikuRepository repository;

  List<Portofolio> _portofolio = [];
  

  PortofolioProvider({required this.repository});

  List<Portofolio> get portofolio => _portofolio;




  Future<void> getPortofolio() async {
    final res = await repository.getPortofolio();
    res.fold(
      (failure) => _portofolio = [],
      (portofolio) => _portofolio = [...portofolio],
    );

    notifyListeners();
  }

  
}
