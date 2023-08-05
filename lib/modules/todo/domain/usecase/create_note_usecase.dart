import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/modules/auth/domain/repository/base_auth_repository.dart';
import 'package:notes/modules/todo/domain/repository/base_todo_repository.dart';

class CreateNoteUseCase {
  BaseToDoRepository baseToDoRepository;
  CreateNoteUseCase(this.baseToDoRepository);
  Future<Either<Failure, Unit>> call({
   required String name,
    required  String description,
    required  String date,
    required  int id,
    required  String color,
  }) async {
  return   await baseToDoRepository.createToDo(name: name, description: description, date: date, color: color,id: id);
  }
}
