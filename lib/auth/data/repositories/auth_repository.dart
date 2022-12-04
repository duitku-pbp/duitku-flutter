import 'package:dartz/dartz.dart';
import 'package:duitku/auth/data/datasources/auth_datasource.dart';
import 'package:duitku/auth/data/messages/login_request.dart';
import 'package:duitku/common/exceptions.dart';
import 'package:duitku/common/failures.dart';

class AuthRepository {
  final AuthDatasource datasource;

  AuthRepository({required this.datasource});

  Future<Either<Failure, String>> login({required LoginRequest body}) async {
    try {
      final res = await datasource.login(body: body);
      return Right(res);
    } on HttpException catch (err) {
      return Left(HttpFailure(err.message));
    }
  }

  Future<void> logout() async {
    await datasource.logout();
  }
}
