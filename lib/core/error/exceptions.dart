
import 'package:notes/core/error/failure.dart';
import 'package:notes/core/network/auth_error_message_model.dart';

class ServerExceptions implements Exception {
  final ErrorMessageModel errorMessageModel;
  ServerExceptions({
    required this.errorMessageModel,
  });
}
class OtpExceptions implements Exception{
  final String errorExceptions;

  OtpExceptions({required this.errorExceptions});
}

// if worke with local data source
class LocalDataBaseException implements Exception {
  final ErrorMessageModel errorMessageModel;
  LocalDataBaseException({
    required this.errorMessageModel,
  });
}

class ServerFailure extends Failure {
  ServerFailure(super.authErrorMessageModel);
}

class DataBaseFailure extends Failure {
  const DataBaseFailure(super.message);
}
