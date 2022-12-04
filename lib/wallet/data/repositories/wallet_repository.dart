import 'package:dartz/dartz.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/common/failures.dart';
import 'package:duitku/wallet/data/datasources/wallet_datasource.dart';
import 'package:duitku/wallet/data/messages/create_transaction_request.dart';
import 'package:duitku/wallet/data/messages/create_wallet_request.dart';
import 'package:duitku/wallet/data/models/report.dart';
import 'package:duitku/wallet/data/models/transaction_group.dart';
import 'package:duitku/wallet/data/models/wallet.dart';

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

  Future<Either<Failure, List<TransactionGroup>>> getTransactions([
    String wallet = "all",
  ]) async {
    try {
      final res = await datasource.getTransactions(wallet);
      return Right(res);
    } on HttpException {
      return Left(HttpFailure("An error occured"));
    }
  }

  Future<Either<Failure, void>> createWallet({
    required CreateWalletRequest body,
  }) async {
    try {
      final res = await datasource.createWallet(body: body);
      return Right(res);
    } on HttpException catch (err) {
      return Left(HttpFailure(err.message));
    }
  }

  Future<Either<Failure, void>> createTransaction({
    required CreateTransactionRequest body,
  }) async {
    try {
      final res = await datasource.createTransaction(body: body);
      return Right(res);
    } on HttpException catch (err) {
      return Left(HttpFailure(err.message));
    }
  }
}
