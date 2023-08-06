import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/core/utilis/enums.dart';
import 'package:notes/modules/auth/domain/entities/auth.dart';
import 'package:notes/modules/auth/domain/usecase/login_usecase.dart';
import 'package:notes/modules/auth/presentation/controller/bloc/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;

  AuthBloc(this.loginUsecase )
      : super(AuthState()) {
    on<AuthEvent>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (event is LoginUser) {
        try {
          emit(state.copyWith(
            loginState: RequestState.loading,
          ));
          Either<Failure, Auth> result =
              await loginUsecase(email: event.email,password: event.password);
          result.fold(
            (Failure l) => emit(state.copyWith(
                loginState: RequestState.error,
                message: l.authErrorMessageModel.en)),
            (Auth r) {
              pref.setString("token", r.token);
              emit(state.copyWith(
                  userResponse: r, loginState: RequestState.loaded));
            },
          );
        } on Exception catch (e) {
          emit(state.copyWith(
              loginState: RequestState.error, message: "error Auth"));
        }
      }

      // else if (event is refreshToken) {
      //   try {
      //     emit(state.copyWith(
      //       refreshTokenState: RequestState.loading,
      //     ));
      //     Either<Failure, User> result = await refreshTokenUseCase();
      //     result.fold(
      //       (Failure l) => emit(state.copyWith(
      //           refreshTokenState: RequestState.error,
      //           message: l.authErrorMessageModel.en)),
      //       (User r) {
      //         emit(state.copyWith(refreshTokenState: RequestState.loaded));
      //       },
      //     );
      //   } on Exception catch (e) {
      //     emit(state.copyWith(
      //         refreshTokenState: RequestState.error, message: generalSingleton.messageEn));
      //   }
      // }
    });
  }
}
