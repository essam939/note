import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/modules/auth/domain/entities/auth.dart';
import 'package:notes/modules/auth/domain/repository/base_auth_repository.dart';

class LoginUsecase{
  BaseAuthRepository baseAuthRepository;
  LoginUsecase(this.baseAuthRepository);
   Future<Either<Failure, Auth>> call({required String email,required String password}) async{
    return await baseAuthRepository.login(email: email,password: password);
  }
}