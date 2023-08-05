import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/modules/todo/domain/entities/todo_item.dart';
import 'package:notes/modules/auth/domain/repository/base_auth_repository.dart';
import 'package:notes/modules/todo/domain/repository/base_todo_repository.dart';

class GetNoteUseCase {
  BaseToDoRepository baseToDoRepository;
  GetNoteUseCase(this.baseToDoRepository);
  Future<Either<Failure, List<ToDo>>> call() async {
  return  await baseToDoRepository.getToDoList();
  }
}
