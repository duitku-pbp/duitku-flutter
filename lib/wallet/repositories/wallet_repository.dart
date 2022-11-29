import 'package:dartz/dartz.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/common/failures.dart';
import 'package:duitku/wallet/datasources/wallet_datasource.dart';
import 'package:duitku/wallet/models/report.dart';
import 'package:duitku/wallet/models/wallet.dart';

class WalletRepository {
  final WalletDatasource datasource;

  WalletRepository({required this.datasource});

  Future<Either<Failure, List<Wallet>>> getWallets() async {
    try {
      final res = await datasource.getWallets();
      return Right(res);
    } on HttpException {
      return Left(HttpFailure("An error occured"));
    }
  }

  Future<Either<Failure, Report>> getReport(String period) async {
    try {
      final res = await datasource.getReport(period);
      return Right(res);
    } on HttpException {
      return Left(HttpFailure("An error occured"));
    }
  }
}
