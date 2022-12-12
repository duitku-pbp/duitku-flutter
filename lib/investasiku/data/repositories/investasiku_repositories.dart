import 'package:duitku/investasiku/data/portofolio_models.dart';
import 'package:duitku/investasiku/data/datasources/investasiku_datasources.dart';
import 'package:dartz/dartz.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/common/failures.dart';

class InvestasikuRepository {
  final PortofolioDataSources datasource;
  InvestasikuRepository({required this.datasource});
  Future<Either<Failure, List<Portofolio>>> getPortofolio() async {
    try {
      final res = await datasource.fetchPortofolio();
      return Right(res);
    } on HttpException {
      return Left(HttpFailure("An error occured"));
    }
  }
}