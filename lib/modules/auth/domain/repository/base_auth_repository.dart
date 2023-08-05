import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/modules/auth/domain/entities/auth.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, Auth>> login(
      {required String email, required String password});
}
