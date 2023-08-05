import 'package:dartz/dartz.dart';
import 'package:notes/core/error/exceptions.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/modules/auth/data/datasource/auth_remote_datascource.dart';
import 'package:notes/modules/auth/data/model/auth_model.dart';
import 'package:notes/modules/auth/domain/entities/auth.dart';
import 'package:notes/modules/auth/domain/repository/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  BaseAuthRemoteDataSource baseAuthRemoteDataSource;

  AuthRepository(this.baseAuthRemoteDataSource);
  @override
  Future<Either<Failure, Auth>> login(
      {required String email, required String password}) async {
    final AuthModel result =
        await baseAuthRemoteDataSource.login(email: email, password: password);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
