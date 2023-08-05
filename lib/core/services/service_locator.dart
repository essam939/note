import 'package:get_it/get_it.dart';
import 'package:notes/modules/auth/data/datasource/auth_remote_datascource.dart';
import 'package:notes/modules/auth/data/repository/auth_repository.dart';
import 'package:notes/modules/auth/domain/repository/base_auth_repository.dart';
import 'package:notes/modules/todo/data/datasource/todo_remote_datasource.dart';
import 'package:notes/modules/todo/data/repository/todo_repository.dart';
import 'package:notes/modules/todo/domain/repository/base_todo_repository.dart';
import 'package:notes/modules/todo/domain/usecase/create_note_usecase.dart';
import 'package:notes/modules/todo/domain/usecase/delete_note_usecase.dart';
import 'package:notes/modules/todo/domain/usecase/get_note_usecase.dart';
import 'package:notes/modules/auth/domain/usecase/login_usecase.dart';
import 'package:notes/modules/todo/domain/usecase/update_note_usecase.dart';
import 'package:notes/modules/auth/presentation/controller/bloc/auth_bloc.dart';
import 'package:notes/modules/todo/presintaion/controller/todo_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    sl.registerFactory(() => AuthBloc(sl()));
    sl.registerFactory(() => TodoBloc(sl(),sl(),sl(),sl()));

    sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));

    sl.registerLazySingleton<CreateNoteUseCase>(() => CreateNoteUseCase(sl()));
    sl.registerLazySingleton<UpdateNoteUseCase>(() => UpdateNoteUseCase(sl()));
    sl.registerLazySingleton<GetNoteUseCase>(() => GetNoteUseCase(sl()));
    sl.registerLazySingleton<DeleteNoteUseCase>(() => DeleteNoteUseCase(sl()));

    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<BaseToDoRepository>(() => ToDoRepository(sl()));

    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource());
    sl.registerLazySingleton<BaseToDoRemoteDataSource>(
            () => ToDoRemoteDataSource());
  }
}
