import 'package:dio/dio.dart';
import 'package:notes/core/error/exceptions.dart';
import 'package:notes/core/network/api_constance.dart';
import 'package:notes/core/network/auth_error_message_model.dart';
import 'package:notes/core/services/dio_services.dart';
import 'package:notes/modules/auth/data/model/auth_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<AuthModel> login({required String email, required String password});

}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  static final DioService _dioService = DioService();

  @override
  Future<AuthModel> login(
      {required String email, required String password}) async {
    final Map<String, dynamic> body = <String, dynamic>{
      "email": email,
      "password": password
    };
    final Response response = await _dioService.post(
      path: ApiConstance.loginPath,
      authorizationRequired: false,
      data: body,
    );
    if (response.statusCode == 200) {
      return AuthModel.fromJson(response.data!["data"]);
    } else {
      throw ServerExceptions(
          errorMessageModel:
              ErrorMessageModel.fromJson(response.data!['localizedMessage']));
    }
  }
}
