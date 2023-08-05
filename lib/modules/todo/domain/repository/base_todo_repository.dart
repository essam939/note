import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/modules/auth/domain/entities/auth.dart';
import 'package:notes/modules/todo/domain/entities/todo_item.dart';

abstract class BaseToDoRepository {

  Future<Either<Failure, Unit>> createToDo(
      {required String name,
      required String description,
      required String date,
      required int id,
      required String color});
  Future<Either<Failure, Unit>> updateToDo(
      {required String name,
      required String description,
      required String date,
      required int id,
      required String color});

  Future<Either<Failure, Unit>> deleteToDo({required int id});

  Future<Either<Failure, List<ToDo>>> getToDoList();
}
