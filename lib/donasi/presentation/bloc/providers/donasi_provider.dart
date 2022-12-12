import 'package:duitku/donasi/data/repository/donasi_repository.dart';
import 'package:duitku/donasi/data/messages/add_donasi_request.dart';
import 'package:duitku/donasi/data/models/donasi.dart';
import 'package:duitku/donasi/presentation/bloc/states/donasi_states.dart';
import 'package:flutter/foundation.dart';

class DonasiProvider with ChangeNotifier{
  final DonasiRepository repository;

  List<Donasi> _donasi = [];

  AddDonasiState _addDonasiState = AddDonasiInitialState();

  DonasiProvider({required this.repository});

  List<Donasi> get donasi => _donasi;

  AddDonasiState get addDonasiState => _addDonasiState;

  void resetStates(){
    _addDonasiState = AddDonasiInitialState();

    notifyListeners();
  }

  Future<void> getDonasi() async {
    final res = await repository.getDonasi();
    res.fold(
      (failure) => _donasi = [],
      (donasi) => _donasi = [...donasi],
    );

    notifyListeners();
  }

  Future<void> addDonasi({
    required AddDonasiRequest body,
  }) async {
    final res = await repository.addDonasi(body: body);
    res.fold(
      (failure) =>
          _addDonasiState = AddDonasiFailureState(failure.message),
      (ok) => _addDonasiState = AddDonasiOkState(),
    );

    notifyListeners();
  }
}