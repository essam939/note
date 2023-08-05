// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:notes/core/utilis/enums.dart';
import 'package:notes/modules/auth/domain/entities/auth.dart';

class AuthState extends Equatable {
  final RequestState loginState;
  final Auth? userResponse;
  final String message;

  AuthState({
    this.loginState = RequestState.initState,
    this.userResponse,
    this.message = '',
  });

  AuthState copyWith({
    RequestState? loginState,
    Auth? userResponse,
    String? message,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      userResponse: userResponse ?? this.userResponse,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        message,
        loginState,
        userResponse,
      ];
}
