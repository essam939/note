import 'package:dartz/dartz.dart';
import 'package:notes/core/error/exceptions.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/modules/todo/data/datasource/todo_remote_datasource.dart';

import 'package:notes/modules/todo/domain/entities/todo_item.dart';
import 'package:notes/modules/todo/domain/repository/base_todo_repository.dart';

class ToDoRepository extends BaseToDoRepository {
  BaseToDoRemoteDataSource baseToDoRemoteDataSource;

  ToDoRepository(this.baseToDoRemoteDataSource);


  @override
  Future<Either<Failure, Unit>> createToDo({required String name, required String description, required String date, required String color,required int id}) async {
    final Unit result =
        await baseToDoRemoteDataSource.createToDo(name: name, description: description, date: date ,color: color,id:id);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
  @override
  Future<Either<Failure, Unit>> updateToDo({required String name, required String description, required String date, required String color,required int id}) async {
    final Unit result =
    await baseToDoRemoteDataSource.updateToDo(name: name, description: description, date: date ,color: color,id:id);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }

  @override
  Future<Either<Failure, List<ToDo>>> getToDoList() async {
    final List<ToDo> result =
        await baseToDoRemoteDataSource.getTodoList();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteToDo({required int id}) async{
    final Unit result =
        await baseToDoRemoteDataSource.deleteToDo( id:id);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel));
    }
  }
}
