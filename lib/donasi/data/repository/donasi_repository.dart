import 'package:dartz/dartz.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/common/failures.dart';
import 'package:duitku/donasi/data/datasources/donasi_datasource.dart';
import 'package:duitku/donasi/data/messages/add_donasi_request.dart';
import 'package:duitku/donasi/data/models/donasi.dart';

class DonasiRepository{
  final DonasiDatasource datasource;

  DonasiRepository({required this.datasource});

  Future<Either<Failure, List<Donasi>>> getDonasi() async {
    try {
      final res = await datasource.getDonasi();
      return Right(res);
    } on HttpException {
      return Left(HttpFailure("An error occured"));
    }
  }
  
  Future<Either<Failure, void>> addDonasi({
    required AddDonasiRequest body,
  }) async {
    try {
      final res = await datasource.addDonasi(body: body);
      return Right(res);
    } on HttpException catch (err) {
      return Left(HttpFailure(err.message));
    }
  }
}