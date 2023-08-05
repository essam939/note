
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:notes/core/network/api_constance.dart';


class DioService {
  factory DioService() => _instance;

  static final DioService _instance = DioService._internal();

  DioService._internal() {
    _dio = Dio();
    final String baseUrl = ApiConstance.getAppBaseUrl();

    _dio.options.baseUrl = baseUrl;

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (Object? object) => log(object.toString(), name: 'HTTP'),
        ),
      );
    }
  }

  late final Dio _dio;



  Future<Response<T>> post<T>({
    required String path,
    Map<String, dynamic>? data,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool authorizationRequired = false,
  }) async {
    // if (authorizationRequired) {
    //   final Box box = Hive.box("userBox");
    //   User? user = box.get("UserModel");
    //   String? accessToken = user?.accessToken;

    //   if (accessToken != null) {
    //     options ??= Options();
    //     options.headers ??= <String, dynamic>{};
    //     options.headers!['Authorization'] = 'Bearer $accessToken';
    //   }
    // }

    return _instance._dio.post<T>(
      path,
      data: data ?? formData,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // Future<Response<T>> postRefreshToken<T>({
  //   required String path,
  // }) async {
  //   String? refreshToken = user?.refreshToken;
  //   Options options = Options();
  //   if (refreshToken != null) {
  //     options.headers = <String, dynamic>{};
  //     options.headers!['Authorization'] = 'Bearer $refreshToken';
  //   }

  //   return _instance._dio.post<T>(
  //     path,
  //     options: options,
  //   );
  // }

}
